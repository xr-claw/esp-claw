-- I2C RGB Light Controller
-- I2C addr: 0x20, SDA=IO1, SCL=IO2
-- Command format: [0xFF, 0x03, 0x01, R, G, B, 0xFF]

local i2c = require("i2c")

local a = type(args) == "table" and args or {}

local colors = {
    red = { 1, 0, 0 },
    green = { 0, 1, 0 },
    blue = { 0, 0, 1 },
    yellow = { 1, 1, 0 },
    cyan = { 0, 1, 1 },
    purple = { 1, 0, 1 },
    white = { 1, 1, 1 },
    off = { 0, 0, 0 },
}

local r, g, b
if a.r ~= nil and a.g ~= nil and a.b ~= nil then
    r, g, b = a.r, a.g, a.b
else
    local c = colors[(a.color or "white"):lower()]
    if c then
        r, g, b = c[1], c[2], c[3]
    else
        error("Unknown color: " .. tostring(a.color))
    end
end

r = (r ~= 0) and 1 or 0
g = (g ~= 0) and 1 or 0
b = (b ~= 0) and 1 or 0

local bus = i2c.new(0, 1, 2, 400000)
local dev = bus:device(0x20)
dev:write({ 0xFF, 0x03, 0x01, r, g, b, 0xFF })
dev:close()
bus:close()
