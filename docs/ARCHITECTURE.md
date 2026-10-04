# ARCHITECTURE.md

## 系统全景图

```
                    ┌─────────────────┐
  Browser ────────► │  apps/web       │
  (Next.js :3000)   │  App Router     │
                    └────────┬────────┘
                             │ HTTP (future: REST/JSON)
                             ▼
                    ┌─────────────────┐
                    │  apps/api       │
                    │  Fastify :3001  │
                    └────────┬────────┘
                             │
              ┌──────────────┴──────────────┐
              ▼                             ▼
     ┌─────────────────┐           ┌─────────────────┐
     │ packages/shared │           │  Persistence    │
     │ Zod + types     │           │  (TBD: PG)      │
     └─────────────────┘           └─────────────────┘
```

## 组件清单

| 组件 | 职责 | 关键路径 |
| --- | --- | --- |
| Web | 页面、客户端交互、调用 API | `apps/web/src/` |
| API | HTTP 入口、鉴权（未来）、领域编排 | `apps/api/src/` |
| Shared | 跨端 DTO / Zod schema、纯函数 | `packages/shared/src/` |

## 模块边界

- `apps/web` 与 `apps/api` **不得**互相 import。
- 共享契约只放在 `packages/shared`；两端通过 package 名 `@chinatrip/shared` 引用。
- `packages/shared` 保持无 I/O、无框架依赖（仅 Zod 等纯库）。
- 副作用（DB、HTTP 客户端、文件）只在 `apps/api`（或未来 `packages/db`）出现。

## 关键数据流（当前骨架）

- 健康检查：`shared.createHealthResponse` → Web 首页展示 / API `GET /health` 返回 JSON。

## 外部依赖（规划）

| 依赖 | 用途 | 说明 |
| --- | --- | --- |
| PostgreSQL | 行程与用户持久化 | 首个数据能力 change 时引入 |
| 对象存储 | 封面图、附件 | 非 MVP |

## 非目标

- 不做微服务拆分；单 API 进程直到规模证明需要。
- Web 不做原生 App；响应式 Web 优先。
- 不在 shared 包内放 React 或 Fastify 类型。

## 相关 spec

见 `openspec/specs/README.md`（能力 spec 随 archive 增长）。
