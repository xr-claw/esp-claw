-- Read the 5-channel I2C line-tracking sensor once.
-- Defaults: addr=0x18, SDA=IO1, SCL=IO2, port=0, freq=400000
-- Command flow: write 0x05 -> wait 50ms -> read 2 bytes -> decode byte0

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

local function is_active(state, mask)
    return (state & mask) ~= 0
end

local bus = i2c.new(port, sda, scl, freq_hz)
local dev = bus:device(addr)

dev:write({ read_cmd })
delay.delay_ms(sample_delay_ms)

local raw = dev:read(2)
local raw_byte = string.byte(raw, 1) or 0
local state = decode_state(raw_byte)
local pattern = state_to_pattern(state)

local result = {
    raw_byte = raw_byte,
    state = state,
    pattern = pattern,
    channel_1 = is_active(state, 0x01),
    channel_2 = is_active(state, 0x02),
    channel_3 = is_active(state, 0x04),
    channel_4 = is_active(state, 0x08),
    channel_5 = is_active(state, 0x10),
}

print(string.format(
    "[ir5] raw=0x%02X state=0x%02X pattern(ch5->ch1)=%s ch1=%s ch2=%s ch3=%s ch4=%s ch5=%s",
    result.raw_byte,
    result.state,
    result.pattern,
    tostring(result.channel_1),
    tostring(result.channel_2),
    tostring(result.channel_3),
    tostring(result.channel_4),
    tostring(result.channel_5)
))

dev:close()
bus:close()

return result
