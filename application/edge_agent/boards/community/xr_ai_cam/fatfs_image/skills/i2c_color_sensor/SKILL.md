---
{
  "name": "i2c_color_sensor",
  "description": "Read the external I2C color sensor, report raw RGBC values, hue, and the classified color name.",
  "metadata": {
    "cap_groups": [
      "cap_lua"
    ],
    "manage_mode": "readonly"
  }
}
---

# I2C Color Sensor

Use this skill to read the external TCS34725-style I2C color sensor on `xr_ai_cam`.

Default bus settings:

- `addr = 0x29`
- `port = 0`
- `SDA = GPIO1`
- `SCL = GPIO2`
- `freq_hz = 400000`

The script performs the reference init sequence before reading color data, then returns:

- raw `r`, `g`, `b`, `c`
- `hue` in degrees
- `color` classification: `Red`, `Green`, `Blue`, `Yellow`, `Cyan`, `Pink`, or `Unknown`

Run exactly one Lua script:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_color_sensor.lua","args":{},"timeout_ms":10000}
```

## Args Schema

```json
{
  "type": "object",
  "properties": {
    "port": {
      "type": "integer",
      "default": 0
    },
    "sda": {
      "type": "integer",
      "default": 1
    },
    "scl": {
      "type": "integer",
      "default": 2
    },
    "freq_hz": {
      "type": "integer",
      "default": 400000
    },
    "addr": {
      "type": "integer",
      "default": 41
    },
    "init_sensor": {
      "type": "boolean",
      "default": true
    },
    "boot_wait_ms": {
      "type": "integer",
      "default": 500
    },
    "step_wait_ms": {
      "type": "integer",
      "default": 10
    },
    "settle_wait_ms": {
      "type": "integer",
      "default": 100
    }
  }
}
```

## Tool Call Examples

Read color once with defaults:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_color_sensor.lua","args":{},"timeout_ms":10000}
```

Read color without re-running the init sequence:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_color_sensor.lua","args":{"init_sensor":false},"timeout_ms":10000}
```
