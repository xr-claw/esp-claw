# XR-CLAW 🦞 小R科技 · 小龙虾

<p align="center">
  <em>基于 ESP-Claw 的 AI 智能体硬件平台 | 开源硬件 + 自有 Skill · 从创客到产品</em>
</p>

<p align="center">
  <a href="https://github.com/espressif/esp-claw"><img src="https://img.shields.io/badge/based_on-ESP--Claw-blue?style=flat-square" alt="ESP-Claw" /></a>
  <a href="./LICENSE"><img src="https://img.shields.io/badge/license-Apache%202.0-green?style=flat-square" alt="License" /></a>
</p>

---

> ⚠️ **内部开发仓库** — 这里是 XR-CLAW 的私有开发仓库。
> 对外公开发布在 [xr-claw/esp-claw](https://github.com/xr-claw/esp-claw)

## 📖 这是什么？

XR-CLAW 是小R科技基于乐鑫 [ESP-Claw](https://github.com/espressif/esp-claw) 构建的开源 AI 智能体硬件平台。本仓库是内部开发版本，包含开源硬件设计、玩法文档和扩展 Skill。

## 🗺️ 三阶段路线图

| 阶段 | 内容 | 状态 |
|------|------|:--:|
| **Phase 1** | Fork 官方稳定版 + 开源硬件设计 + 玩法文档 | 🚧 搭建中 |
| **Phase 2** | 自有 compatible Skill 库，兼容官方框架 | 📋 规划中 |
| **Phase 3** | 闭源消费级产品 | 📋 规划中 |

## 🏗️ 目录结构

```
esp-claw/
├── application/         ← 上游 ESP-Claw 应用层
├── components/          ← 上游组件（含官方 Skills）
├── docs/                ← 上游文档
├── xr-hardware/         ← 🆕 开源硬件设计
│   ├── pcb/             # PCB 设计文件
│   ├── schematic/       # 原理图
│   ├── bom/             # BOM 物料清单
│   └── enclosure/       # 外壳 3D 模型
└── xr-docs/             ← 🆕 使用文档
    ├── getting-started/ # 快速上手
    ├── play-guide/      # 玩法指南
    └── faq/             # 常见问题
```

## 🔄 上游同步

`master` 分支追踪 [espressif/esp-claw](https://github.com/espressif/esp-claw)。

```bash
git fetch upstream master
git merge upstream/master
```

## 🚀 协作工作流

1. 从 `xr-main` 创建特性分支：`git checkout -b feature/xxx`
2. 开发完成发起 PR 到 `xr-main`
3. 审核通过后合并
4. 发布时打 tag → Actions 自动推送到 [xr-claw/esp-claw](https://github.com/xr-claw/esp-claw)

## 📄 许可证

- 上游代码：Apache License 2.0
- 硬件设计（xr-hardware/）：CERN-OHL-S-2.0
- 文档（xr-docs/）：CC BY-SA 4.0

---

<p align="center">
  <strong>基于 <a href="https://github.com/espressif/esp-claw">ESP-Claw</a> 构建 🦞</strong>
</p>
