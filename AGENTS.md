# AGENTS.md — ChinaTrip AI 路由入口

> 本仓库采用 **Harness（工作流壳）+ OpenSpec（WHAT）+ Superpowers（HOW）** 开发。
> 写代码前先走启动序列；功能交付走 `/opsx:*` 闭环。细节见根目录 `WORKFLOW.md`。

---

## 项目概览

**ChinaTrip** 是一站式中国旅行规划与行程协作产品：帮助国际/国内旅客发现目的地、编排行程、管理预订信息与同行者协作。

当前阶段：**仓库骨架已就绪**，业务能力通过 OpenSpec change 逐步交付。

---

## 技术栈

| 层 | 选型 | 路径 |
| --- | --- | --- |
| Monorepo | pnpm workspaces | 根 `package.json` + `pnpm-workspace.yaml` |
| Web | Next.js（App Router）+ TypeScript + React | `apps/web/` |
| API | Fastify + TypeScript | `apps/api/` |
| 共享契约 | Zod + 共享类型 | `packages/shared/` |
| 规格与变更 | OpenSpec | `openspec/` |
| AI 工作流 | Cursor `/opsx:*` + Superpowers skills | `.cursor/` |

---

## 快速开始

```bash
# 依赖
pnpm install

# 环境检查 + OpenSpec 活跃变更列表（Windows）
./init.ps1
# 或 Git Bash / WSL
./init.sh

# 开发（实现后启用）
pnpm dev
```

前置：安装 [OpenSpec CLI](https://github.com/Fission-AI/OpenSpec)（`npm i -g @fission-ai/openspec` 或官方文档方式），并在 Cursor 中启用 Superpowers 相关能力。

---

## 启动序列（写代码前必做）

1. 确认在项目根目录（存在 `openspec/config.yaml`）。
2. **完整阅读本文件**。
3. 运行 `init.ps1`（Windows）或 `init.sh`（Unix）；失败则先修复基线。
4. 若用户或任务指向某次变更，阅读：
   - `openspec/changes/<name>/proposal.md`
   - `openspec/changes/<name>/design.md`
   - `openspec/changes/<name>/tasks.md`
5. 涉及的能力域，阅读 `openspec/specs/<capability>/spec.md`（若存在）。

---

## 硬约束

- **单一真相源**：变更产物只在 `openspec/changes/<name>/`；归档后能力规格在 `openspec/specs/`。勿在 `docs/superpowers/` 另建平行副本（brainstorming / writing-plans 输出须写回 change 目录）。
- **TDD 默认**：实现任务须红—绿—重构；声称完成前须跑真实命令并读输出。
- **模块边界**：见 `docs/ARCHITECTURE.md`；`packages/shared` 不得依赖 `apps/*`。
- **语言**：与用户沟通使用中文（见 `.cursor/rules/respond-in-chinese.mdc`）。

---

## 目录地图

```
ChinaTrip/
├── apps/web/          # 前端
├── apps/api/          # 后端 API
├── packages/shared/   # 跨端类型与校验
├── docs/              # 稳定项目知识（架构、产品、规范）
├── openspec/          # 规格与活跃变更
├── .cursor/           # /opsx 命令、skills、rules
├── init.ps1 / init.sh # 基线验证入口
└── WORKFLOW.md        # 固定工作流参考（模板级）
```

---

## 专题文档（按需加载，勿一次全读）

| 需要 | 读 |
| --- | --- |
| 组件边界、数据流、依赖 | `docs/ARCHITECTURE.md` |
| 产品定位、术语、业务规则 | `docs/PRODUCT.md` |
| 命名、测试、提交、PR | `docs/CONVENTIONS.md` |
| docs 索引与如何加文档 | `docs/README.md` |
| OpenSpec + Superpowers 闭环 | `WORKFLOW.md` |
| 用户向说明 | `README.md` |

---

## 常用命令

| 意图 | 命令 |
| --- | --- |
| 探索想法、不写代码 | `/opsx:explore` |
| 小改（<1h） | `/opsx:quick` |
| 新功能/能力 | `/opsx:propose` |
| 深化设计 + TDD 实现 + 验证 | `/opsx:apply` |
| 归档并同步 specs | `/opsx:archive` |
| 查看活跃变更 | `openspec list` |

第一个推荐变更示例：`/opsx:propose 用户注册与登录（邮箱 OTP）`
