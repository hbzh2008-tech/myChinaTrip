# ChinaTrip

中国旅行规划与行程协作 — 全栈 monorepo，采用 **Harness + OpenSpec + Superpowers** 的 AI 辅助交付流程。

---

## 理念一览

| 层 | 职责 |
| --- | --- |
| **Harness** | 固定工作流壳：`AGENTS.md`、`WORKFLOW.md`、`init.*`、`.cursor/` |
| **OpenSpec** | **WHAT**：proposal / design / tasks / 能力规格（`openspec/`） |
| **Superpowers** | **HOW**：brainstorming、writing-plans、TDD、子代理实现与验证 |

闭环：`/opsx:propose` → 人工确认 → `/opsx:apply` → `/opsx:archive`

完整说明见 [WORKFLOW.md](./WORKFLOW.md) 与 [AGENTS.md](./AGENTS.md)。

---

## 仓库结构

```
.
├── apps/
│   ├── web/                 # Next.js 前端
│   └── api/                 # Fastify API
├── packages/
│   └── shared/              # 共享类型与 Zod schema
├── docs/                    # 架构 / 产品 / 编码规范
├── openspec/
│   ├── config.yaml
│   ├── changes/             # 活跃变更（含 archive/）
│   └── specs/               # 能力规格（长期记忆）
├── .cursor/                 # /opsx 命令与 rules
├── init.ps1                 # Windows 基线检查
└── init.sh                  # Unix 基线检查
```

---

## 前置依赖

| 工具 | 用途 |
| --- | --- |
| Node.js ≥ 20 | 运行时 |
| pnpm ≥ 9 | Monorepo |
| [OpenSpec CLI](https://github.com/Fission-AI/OpenSpec) | 规格与变更管理 |
| Cursor + Superpowers | 设计与执行 skills |

---

## 快速开始

```powershell
pnpm install
./init.ps1
```

开发服务（骨架占位，首个 feature change 后完善）：

```powershell
pnpm dev
```

---

## 第一个变更

在 Cursor 中：

```
/opsx:propose 初始化健康检查 API 与 Web 首页
```

审查 `openspec/changes/<name>/proposal.md` 后执行 `/opsx:apply <name>`，完成后 `/opsx:archive <name>`。

---

## 模板来源

工作流壳基于 [CodeTeng/harness-template](https://github.com/CodeTeng/harness-template)（OpenSpec + Superpowers）。升级模板时只合并 `WORKFLOW.md`、`.cursor/`、`openspec/config.yaml` 骨架，保留本项目的 `docs/` 与 `AGENTS.md`。
