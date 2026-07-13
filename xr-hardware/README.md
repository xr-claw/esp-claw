# XR-CLAW Hardware Design 🛠️

XR-CLAW 开源硬件参考设计，基于 ESP32 系列芯片。

## 目录结构

```
xr-hardware/
├── pcb/               # PCB 设计文件（KiCad/EAGLE）
├── schematic/         # 原理图
├── bom/               # BOM 物料清单（含供应商链接）
├── enclosure/         # 外壳 3D 模型（STEP/STL）
├── assembly-guide/    # 组装指南（图片+步骤）
└── datasheets/        # 芯片数据手册
```

## PCB 设计规范

- 主控：ESP32-S3 / ESP32-P4
- 层数：建议 4 层
- 最小线宽/线距：6mil
- 接口：USB-C（电源+数据）、I2C/SDIO/GPIO 扩展

## 许可证

CERN Open Hardware Licence Version 2 - Strongly Reciprocal (CERN-OHL-S-2.0)
