local delay = require("delay")
local i2c = require("i2c")

local port = 0
local sda = 1
local scl = 2
local freq_hz = 400000
local addr = 0x1F
local read_cmd = 0x05

local bus = i2c.new(port, sda, scl, freq_hz)
local dev = bus:device(addr)
print(string.format("[rfid] I2C init: port=%d, SDA=%d, SCL=%d, freq=%d, addr=0x%02X", port, sda, scl, freq_hz, addr))

dev:write({ read_cmd })
delay.delay_ms(50)

local raw = dev:read(5)
local data = {
    string.byte(raw, 2) or 0,
    string.byte(raw, 3) or 0,
    string.byte(raw, 4) or 0,
    string.byte(raw, 5) or 0,
}
local parts = {}
for i = 1, #data do
    parts[#parts + 1] = string.format("%02X", data[i])
end
local card_id = table.concat(parts)

local result = {
    card_id = card_id,
    bytes = data,
}

print(string.format("[rfid] card_id=%s", result.card_id))

dev:close()
bus:close()

return result
