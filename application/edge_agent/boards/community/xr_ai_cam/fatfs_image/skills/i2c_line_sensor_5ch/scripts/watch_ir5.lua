-- Continuously read the 5-channel line sensor and print the decoded state.
-- Defaults: addr=0x18, SDA=IO1, SCL=IO2, port=0, freq=400000

local delay = require("delay")
local i2c = require("i2c")

local a = type(args) == "table" and args or {}
local port = a.port or 0
local sda = a.sda or 1
local scl = a.scl or 2
local freq_hz = a.freq_hz or 400000
local addr = a.addr or 0x18
local read_cmd = a.read_cmd or 0x05
local sample_delay_ms = a.sample_delay_ms or 50
local interval_ms = a.interval_ms or 200
local count = a.count or 0
local only_on_change = a.only_on_change

if only_on_change == nil then
    only_on_change = true
end

local function decode_state(raw_byte)
    local state = 0
    if (raw_byte & 0x01) ~= 0 then
        state = state | 0x10
    end
    if (raw_byte & 0x02) ~= 0 then
        state = state | 0x08
    end
    if (raw_byte & 0x04) ~= 0 then
        state = state | 0x04
    end
    if (raw_byte & 0x08) ~= 0 then
        state = state | 0x02
    end
    if (raw_byte & 0x10) ~= 0 then
        state = state | 0x01
    end
    return state
end

local function state_to_pattern(state)
    local chars = {}
    for bit = 4, 0, -1 do
        if (state & (1 << bit)) ~= 0 then
            chars[#chars + 1] = "1"
        else
            chars[#chars + 1] = "0"
        end
    end
    return table.concat(chars)
end

local bus = i2c.new(port, sda, scl, freq_hz)
local dev = bus:device(addr)

local last_state = -1
local index = 0

while count == 0 or index < count do
    dev:write({ read_cmd })
    delay.delay_ms(sample_delay_ms)

    local raw = dev:read(2)
    local raw_byte = string.byte(raw, 1) or 0
    local state = decode_state(raw_byte)

    if (not only_on_change) or state ~= last_state then
        print(string.format(
            "[ir5_watch] sample=%d raw=0x%02X state=0x%02X pattern(ch5->ch1)=%s",
            index + 1,
            raw_byte,
            state,
            state_to_pattern(state)
        ))
        last_state = state
    end

    index = index + 1
    if count == 0 or index < count then
        delay.delay_ms(interval_ms)
    end
end

dev:close()
bus:close()
