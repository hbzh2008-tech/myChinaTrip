# ARCHITECTURE.md

## 系统全景图

```
                    ┌─────────────────┐
  Browser ────────► │  frontend/      │
  (Next.js :3000)   │  App Router     │
                    └────────┬────────┘
                             │ HTTP (REST/JSON)
                             ▼
                    ┌─────────────────┐
                    │  backend/       │
                    │  Spring Boot 3  │
                    │  :3001          │
                    └────────┬────────┘
                             │
              ┌──────────────┴──────────────┐
              ▼                             ▼
     ┌─────────────────┐           ┌─────────────────┐
     │ packages/shared │           │  MySQL 8        │
     │ Zod + types     │           │  Spring Data JPA│
     │ (契约文档源)      │           │  (首个 DB change)│
     └─────────────────┘           └─────────────────┘
```

## 组件清单

| 组件 | 职责 | 关键路径 |
| --- | --- | --- |
| Web | 页面、客户端交互、调用 API | `frontend/src/` |
| API | HTTP 入口、鉴权（未来）、领域编排 | `backend/src/main/java/` |
| Shared | 跨端 DTO / Zod schema、纯函数 | `packages/shared/src/` |

## 模块边界

- `frontend/` 与 `backend/` **不得**互相 import。
- 共享契约以 `packages/shared` 的 Zod schema 为**文档真相源**；Java DTO / OpenAPI 须与之间 JSON 对齐（稳定后可 codegen）。
- `packages/shared` 保持无 I/O、无框架依赖（仅 Zod 等纯库）。
- 副作用（DB、HTTP 客户端、文件）只在 `backend/`（或未来独立 `packages`）出现。

## 后端选型（Spring Boot 3）

| 考量 | 说明 |
| --- | --- |
| 扩展 | 分层（Controller / Service / Repository）、Spring Security、事务、消息、调度成熟 |
| 持久化 | Spring Data JPA + **MySQL 8**（InnoDB）为默认演进路径 |
| 部署 | 可执行 JAR + Docker；与 K8s/企业 CI 模板兼容 |
| 契约 | MVP 手对齐 JSON；后续可 `springdoc-openapi` + 从 OpenAPI 生成 TS 客户端 |

## 关键数据流（当前骨架）

- 健康检查：`shared.createHealthResponse`（Web）与 `GET /health`（API）返回相同 JSON 形状。

## 数据存储（MySQL）

| 项 | 选型 |
| --- | --- |
| 引擎 | **MySQL 8.x**，默认存储引擎 InnoDB |
| 字符集 | `utf8mb4` + `utf8mb4_unicode_ci`（支持 emoji 与完整 Unicode） |
| 访问层 | Spring Data JPA + Hibernate；Schema 变更用 **Flyway**（首个 DB change 引入） |
| 连接 | 本地/Docker 开发实例；生产用托管 MySQL 或自建主从（非 MVP 范围） |
| 时区 | JDBC URL 显式 `serverTimezone`（建议 `Asia/Shanghai` 或与业务统一的 UTC 策略） |

与 Spring Boot 集成时使用 `spring-boot-starter-data-jpa` + MySQL Connector/J；**不在** `packages/shared` 中放 SQL 或 ORM 类型。

## 外部依赖（规划）

| 依赖 | 用途 | 说明 |
| --- | --- | --- |
| MySQL 8 | 行程与用户持久化 | 首个数据能力 change 时引入 |
| 对象存储 | 封面图、附件 | 非 MVP |

## 非目标

- 不做微服务拆分；单 API 进程直到规模证明需要。
- Web 不做原生 App；响应式 Web 优先。
- 不在 shared 包内放 React 或 Spring 类型。

## 相关 spec

见 `openspec/specs/README.md`（能力 spec 随 archive 增长）。
