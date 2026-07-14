---
{
  "name": "i2c_line_sensor_5ch",
  "description": "Read the external 5-channel I2C line-tracking sensor and report the decoded five-lane state.",
  "metadata": {
    "cap_groups": [
      "cap_lua"
    ],
    "manage_mode": "readonly"
  }
}
---

# I2C 5-Channel Line Sensor

Use this skill to read the 5-channel line-tracking sensor on `xr_ai_cam`.

Default bus settings:

- `addr = 0x18`
- `port = 0`
- `SDA = GPIO1`
- `SCL = GPIO2`
- `freq_hz = 400000`
- `read_cmd = 0x05`
- `sample_delay_ms = 50`

The decoded `state` follows the same bit order as the reference Blockly logic:

- `channel 1 -> bit 0 -> 0x01`
- `channel 2 -> bit 1 -> 0x02`
- `channel 3 -> bit 2 -> 0x04`
- `channel 4 -> bit 3 -> 0x08`
- `channel 5 -> bit 4 -> 0x10`

Run exactly one Lua script:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_ir5.lua","args":{},"timeout_ms":10000}
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
      "default": 24
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

Read once with defaults:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_ir5.lua","args":{},"timeout_ms":10000}
```

Read once with an explicit address:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_ir5.lua","args":{"addr":24},"timeout_ms":10000}
```

For board-side continuous observation, use the example watcher script:

```json
{"path":"{CUR_SKILL_DIR}/scripts/watch_ir5.lua","args":{"interval_ms":200,"count":20},"timeout_ms":15000}
```
