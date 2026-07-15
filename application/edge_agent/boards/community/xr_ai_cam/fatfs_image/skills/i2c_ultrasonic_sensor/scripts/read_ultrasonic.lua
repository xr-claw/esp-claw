-- Read the I2C ultrasonic sensor once.
-- Defaults: addr=0x21, SDA=IO1, SCL=IO2, port=0, freq=400000
-- Command flow: write 0x05 -> wait 50ms -> read 2 bytes -> take byte0 -> distance_cm = raw / 2

local delay = require("delay")
local i2c = require("i2c")

local a = type(args) == "table" and args or {}
local port = a.port or 0
local sda = a.sda or 1
local scl = a.scl or 2
local freq_hz = a.freq_hz or 400000
local addr = a.addr or 0x21
local read_cmd = a.read_cmd or 0x05
local sample_delay_ms = a.sample_delay_ms or 50

local bus = i2c.new(port, sda, scl, freq_hz)
local dev = bus:device(addr)

dev:write({ read_cmd })
delay.delay_ms(sample_delay_ms)

local raw = dev:read(2)
local raw_byte = string.byte(raw, 1) or 0
local distance_cm = raw_byte / 2

local result = {
    raw_byte = raw_byte,
    distance_cm = distance_cm,
}

print(string.format(
    "[ultrasonic] raw=0x%02X distance_cm=%.1f",
    result.raw_byte,
    result.distance_cm
))

dev:close()
bus:close()

return result
