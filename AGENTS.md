# AGENTS.md — ChinaTrip AI WorkSpace 路由入口

> 本仓库是 **AI WorkSpace 超项目（Harness 壳）**：OpenSpec、文档、共享契约与子模块 pin 在此维护。
> 前端与后端为 **独立 Git 仓库**，以 submodule 挂在 `frontend/`、`backend/`。
> 写代码前先走启动序列；功能交付走 `/opsx:*` 闭环。细节见根目录 `WORKFLOW.md`。

---

## 项目概览

**ChinaTrip** 是一站式中国旅行规划与行程协作产品：帮助国际/国内旅客发现目的地、编排行程、管理预订信息与同行者协作。

**AI WorkSpace 布局**：在 Cursor 中打开**本仓库根目录**（不是只打开某个子模块），以便同时看到 Harness、`openspec/`、`docs/`、`packages/shared/` 以及两个应用子模块。

当前阶段：**WorkSpace 骨架与子模块已就绪**，业务能力通过 OpenSpec change 逐步交付。

---

## 技术栈

| 层 | 选型 | 路径 |
| --- | --- | --- |
| WorkSpace 壳 | Harness + OpenSpec + pnpm | 仓库根 |
| 前端（submodule） | Next.js（App Router）+ TypeScript + React | `frontend/` |
| 后端（submodule） | Spring Boot 3 + Java 17 | `backend/` |
| 共享契约 | Zod + 共享类型 | `packages/shared/` |
| 规格与变更 | OpenSpec | `openspec/` |
| AI 工作流 | Cursor `/opsx:*` + Superpowers skills | `.cursor/` |

---

## 远程仓库

| 角色 | SSH URL |
| --- | --- |
| **WorkSpace 超项目** | `git@github.com:hbzh2008-tech/myChinaTrip.git` |
| **前端子模块** | `git@github.com:hbzh2008-tech/myChinaTrip-frontend.git` |
| **后端子模块** | `git@github.com:hbzh2008-tech/myChinaTrip-backend.git` |

HTTPS 克隆可将 `git@github.com:` 换成 `https://github.com/`（路径相同）。

## 子模块：`frontend/` 与 `backend/`

| 目录 | 挂载路径 | 职责 |
| --- | --- | --- |
| `frontend/` | Next.js 15（App Router），开发端口 **3000** | Web UI、页面与客户端逻辑，调用后端 API |
| `backend/` | Spring Boot 3，开发端口 **3001** | HTTP API、领域编排与持久化（JPA/MySQL 8 规划中） |

首次在本机挂子模块（空 WorkSpace 或尚未有 `frontend/`、`backend/` 时）：

```bash
git submodule add git@github.com:hbzh2008-tech/myChinaTrip-frontend.git frontend
git submodule add git@github.com:hbzh2008-tech/myChinaTrip-backend.git backend
```

本仓库已完成上述挂载；日常只需 `git submodule update --init --recursive`。

### Agent 在子模块里改代码前

1. 确认当前任务属于前端、后端还是 WorkSpace 壳（OpenSpec / shared / 文档）。
2. 若改动在 `frontend/` 或 `backend/`：**先读该目录下的 `README.md`（若有）及子模块内约定**；跨端契约以 `packages/shared/` 与 `openspec/specs/` 为准。
3. **WorkSpace 级规则优先**：子模块内说明若与本文（submodule 工作流、OpenSpec、TDD、`init.*`）冲突，以**本文为准**。

### Submodule 常用命令

```bash
# 首次克隆（含子模块）
git clone --recurse-submodules git@github.com:hbzh2008-tech/myChinaTrip.git

# 已克隆但未拉子模块
git submodule update --init --recursive

# 在子模块内开发：先提交并推送子模块，再在超项目更新 pin 并提交
cd frontend && git push && cd ..
git add frontend && git commit -m "chore: bump frontend submodule"
```

推送子模块后再更新超项目 pin，避免他人/CI 拉到不存在的 commit。

---

## 快速开始

```bash
# 子模块 + 依赖
git submodule update --init --recursive
pnpm install

# 环境检查 + OpenSpec 活跃变更列表（Windows）
./init.ps1
# 或 Git Bash / WSL
./init.sh

# 开发（frontend :3000，backend :3001）
pnpm dev
pnpm dev:api   # 或 backend/ 下 gradlew bootRun
```

前置：安装 [OpenSpec CLI](https://github.com/Fission-AI/OpenSpec)（`npm i -g @fission-ai/openspec` 或官方文档方式），并在 Cursor 中启用 Superpowers 相关能力。

---

## 启动序列（写代码前必做）

1. 确认在项目根目录（存在 `openspec/config.yaml` 与 `.gitmodules`）。
2. **完整阅读本文件**。
3. 运行 `init.ps1`（Windows）或 `init.sh`（Unix）；失败则先修复基线。
4. 若用户或任务指向某次变更，阅读：
   - `openspec/changes/<name>/proposal.md`
   - `openspec/changes/<name>/design.md`
   - `openspec/changes/<name>/tasks.md`
5. 涉及的能力域，阅读 `openspec/specs/<capability>/spec.md`（若存在）。
6. 若任务仅涉及 `frontend/` 或 `backend/`，进入对应目录前确认子模块已初始化且无意外 detached 状态。

---

## 硬约束

- **单一真相源**：变更产物只在 `openspec/changes/<name>/`；归档后能力规格在 `openspec/specs/`。勿在 `docs/superpowers/` 另建平行副本（brainstorming / writing-plans 输出须写回 change 目录）。
- **TDD 默认**：实现任务须红—绿—重构；声称完成前须跑真实命令并读输出。
- **模块边界**：见 `docs/ARCHITECTURE.md`；`packages/shared` 不得依赖 `frontend/` 或 `backend/`；`frontend/` 与 `backend/` **不得**互相 import。
- **子模块边界**：不要在超项目根目录复制一份应用源码；应用代码只存在于 `frontend/`、`backend/` 子模块内。
- **语言**：与用户沟通使用中文（见 `.cursor/rules/respond-in-chinese.mdc`）。

---

## 目录地图

```
ChinaTrip/                 # AI WorkSpace 超项目
├── frontend/              # git submodule — Next.js 前端
├── backend/               # git submodule — Spring Boot 3 API
├── packages/shared/       # 跨端类型与校验（留在超项目）
├── docs/                  # 稳定项目知识（架构、产品、规范）
├── openspec/              # 规格与活跃变更
├── .cursor/               # /opsx 命令、skills、rules
├── init.ps1 / init.sh     # 基线验证入口
└── WORKFLOW.md            # 固定工作流参考（模板级）
```

子模块 pin 记录在超项目的 `frontend`、`backend` 两个 gitlink；源码分别在上述两个 GitHub 仓库的 `main` 分支。

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
| 同步子模块检出 | `git submodule update --init --recursive` |

第一个推荐变更示例：`/opsx:propose 用户注册与登录（邮箱 OTP）`
