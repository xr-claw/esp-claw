---
{
  "name": "i2c_rgb_light",
  "description": "Control the external I2C RGB light with fixed red green blue states. Use when the user asks to set this board's RGB light color.",
  "metadata": {
    "cap_groups": [
      "cap_lua"
    ],
    "manage_mode": "readonly"
  }
}
---

# I2C RGB Light

Use this skill to control the external I2C RGB light on `xr_ai_cam`.

The tested default bus settings are:

- `addr = 0x20`
- `port = 0`
- `SDA = GPIO1`
- `SCL = GPIO2`
- `freq_hz = 400000`

Run exactly one Lua script:

```json
{"path":"{CUR_SKILL_DIR}/scripts/i2c_rgb_switch.lua","args":{"color":"red"},"timeout_ms":10000}
```

## Args Schema

```json
{
  "type": "object",
  "properties": {
    "color": {
      "type": "string",
      "description": "Named color: red, green, blue, yellow, cyan, purple, white, off"
    },
    "r": {
      "type": "integer",
      "minimum": 0,
      "maximum": 1
    },
    "g": {
      "type": "integer",
      "minimum": 0,
      "maximum": 1
    },
    "b": {
      "type": "integer",
      "minimum": 0,
      "maximum": 1
    }
  }
}
```

If `r`, `g`, and `b` are all present, the script uses them directly. Otherwise it resolves the named `color`.

## Tool Call Examples

Set red:

```json
{"path":"{CUR_SKILL_DIR}/scripts/i2c_rgb_switch.lua","args":{"color":"red"},"timeout_ms":10000}
```

Set white:

```json
{"path":"{CUR_SKILL_DIR}/scripts/i2c_rgb_switch.lua","args":{"color":"white"},"timeout_ms":10000}
```

Turn off:

```json
{"path":"{CUR_SKILL_DIR}/scripts/i2c_rgb_switch.lua","args":{"color":"off"},"timeout_ms":10000}
```

Set by raw RGB bits:

```json
{"path":"{CUR_SKILL_DIR}/scripts/i2c_rgb_switch.lua","args":{"r":1,"g":0,"b":1},"timeout_ms":10000}
```
