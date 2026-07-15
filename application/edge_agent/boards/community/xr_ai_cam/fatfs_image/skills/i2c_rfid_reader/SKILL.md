---
{
  "name": "i2c_rfid_reader",
  "description": "Read the external I2C RFID reader and report the detected card ID as an uppercase hex string.",
  "metadata": {
    "cap_groups": [
      "cap_lua"
    ],
    "manage_mode": "readonly"
  }
}
---

# I2C RFID Reader

Use this skill to read the external RFID card ID once on `xr_ai_cam`.

Default bus settings:

- `addr = 0x1F`
- `port = 0`
- `SDA = GPIO1`
- `SCL = GPIO2`
- `freq_hz = 400000`
- `read_cmd = 0x05`
- `sample_delay_ms = 50`

The script follows the reference logic:

1. Write `0x05` to the device
2. Wait `50 ms`
3. Read `5` bytes
4. Ignore byte `0`
5. Convert bytes `1..4` to an uppercase hex card ID string
6. Return the card ID for the current read

Run exactly one Lua script:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_rfid.lua","args":{},"timeout_ms":10000}
```

## Tool Call Examples

Read RFID card ID once:

```json
{"path":"{CUR_SKILL_DIR}/scripts/read_rfid.lua","args":{},"timeout_ms":10000}
```
