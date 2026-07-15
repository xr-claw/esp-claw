---
{
  "name": "i2c_ultrasonic_sensor",
  "description": "Read the external I2C ultrasonic sensor and report distance in centimeters.",
  "metadata": {
    "cap_groups": [
      "cap_lua"
    ],
    "manage_mode": "readonly"
  }
}
---

# I2C Ultrasonic Sensor

Use this skill to read the external ultrasonic distance sensor on `xr_ai_cam`.

Default bus settings:

- `addr = 0x21`
- `port = 0`
- `SDA = GPIO1`
- `SCL = GPIO2`
- `freq_hz = 400000`
- `read_cmd = 0x05`
- `sample_delay_ms = 50`

The script follows the reference logic:

1. Write `0x05` to the device
2. Wait `50 ms`
3. Read `2` bytes and take the first byte
4. Return `distance_cm = raw / 2`

Run exactly one Lua script:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_ultrasonic.lua","args":{},"timeout_ms":10000}
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
      "default": 33
    },
    "read_cmd": {
      "type": "integer",
      "default": 5
    },
    "sample_delay_ms": {
      "type": "integer",
      "default": 50
    }
  }
}
```

## Tool Call Examples

Read distance once with defaults:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_ultrasonic.lua","args":{},"timeout_ms":10000}
```

Read distance with an explicit address:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_ultrasonic.lua","args":{"addr":33},"timeout_ms":10000}
```
