-- Read a TCS34725-style I2C color sensor once.
-- Defaults: addr=0x29, SDA=IO1, SCL=IO2, port=0, freq=400000

local delay = require("delay")
local i2c = require("i2c")

local a = type(args) == "table" and args or {}
local port = a.port or 0
local sda = a.sda or 1
local scl = a.scl or 2
local freq_hz = a.freq_hz or 400000
local addr = a.addr or 0x29
local init_sensor = a.init_sensor
local boot_wait_ms = a.boot_wait_ms or 500
local step_wait_ms = a.step_wait_ms or 10
local settle_wait_ms = a.settle_wait_ms or 100

if init_sensor == nil then
    init_sensor = true
end

local function find_max(a1, b1, c1)
    if a1 >= b1 and a1 >= c1 then
        return a1
    elseif b1 >= a1 and b1 >= c1 then
        return b1
    else
        return c1
    end
end

local function find_min(a1, b1, c1)
    if a1 <= b1 and a1 <= c1 then
        return a1
    elseif b1 <= a1 and b1 <= c1 then
        return b1
    else
        return c1
    end
end

local function calculate_hue(r, g, b, c)
    if c <= 0 then
        return 0
    end

    local r_norm = r * 100 / c
    local g_norm = g * 100 / c
    local b_norm = b * 100 / c
    local max_val = find_max(r_norm, g_norm, b_norm)
    local min_val = find_min(r_norm, g_norm, b_norm)
    local dif_val = max_val - min_val

    if max_val == min_val then
        return 0
    end

    local h = 0
    if max_val == r_norm then
        if g_norm >= b_norm then
            h = 60 * (g_norm - b_norm) / dif_val
        else
            h = 60 * (g_norm - b_norm) / dif_val + 360
        end
    elseif max_val == g_norm then
        h = 60 * (b_norm - r_norm) / dif_val + 120
    else
        h = 60 * (r_norm - g_norm) / dif_val + 240
    end

    if h < 0 then
        h = h + 360
    end
    return math.floor(h + 0.5)
end

local function classify_color(h)
    if h > 330 or h < 30 then
        return "Red"
    elseif h < 150 and h > 90 then
        return "Green"
    elseif h < 270 and h > 190 then
        return "Blue"
    elseif h > 30 and h < 90 then
        return "Yellow"
    elseif h > 150 and h < 190 then
        return "Cyan"
    elseif h > 270 and h < 330 then
        return "Pink"
    end
    return "Unknown"
end

local bus = i2c.new(port, sda, scl, freq_hz)
local dev = bus:device(addr)
local CMD_BIT = 0x80

local function write_reg(reg_addr, value)
    dev:write({ reg_addr | CMD_BIT, value })
end

local function read_reg(reg_addr)
    local raw = dev:read(1, reg_addr | CMD_BIT)
    return string.byte(raw, 1) or 0
end

local function read_u16_le(low_reg)
    local low = read_reg(low_reg)
    local high = read_reg(low_reg + 1)
    return (high << 8) | low
end

if init_sensor then
    delay.delay_ms(boot_wait_ms)
    write_reg(0x01, 0xEB)
    delay.delay_ms(step_wait_ms)
    write_reg(0x0F, 0x00)
    delay.delay_ms(step_wait_ms)
    write_reg(0x00, 0x01)
    delay.delay_ms(step_wait_ms)
    write_reg(0x00, 0x03)
    delay.delay_ms(settle_wait_ms)
end

local b = read_u16_le(0x14)
local c = read_u16_le(0x16)
local r = read_u16_le(0x18)
local g = read_u16_le(0x1A)
local hue = calculate_hue(r, g, b, c)
local color = classify_color(hue)

local result = {
    r = r,
    g = g,
    b = b,
    c = c,
    hue = hue,
    color = color,
}

print(string.format(
    "[color_sensor] color=%s hue=%d r=%d g=%d b=%d c=%d",
    result.color,
    result.hue,
    result.r,
    result.g,
    result.b,
    result.c
))

dev:close()
bus:close()

return result
