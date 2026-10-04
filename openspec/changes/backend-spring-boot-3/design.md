# Design: Spring Boot 3 后端

## 架构

- 单模块 Gradle 工程 `chinatrip-api`，包根 `com.chinatrip.api`。
- 分层约定（随能力增长）：`web`（Controller）→ `service` → `repository`（Spring Data JPA + **MySQL 8**）。
- 端口 **3001**，与现有前端约定一致。

## 契约策略

| 层 | 角色 |
| --- | --- |
| `packages/shared` | Zod schema + TS 类型，Harness 内文档真相源 |
| Java `dto` 包 | 与 JSON 字段对齐；集成测试断言响应体 |
| 未来 | `springdoc-openapi` 发布 OpenAPI，可选生成 TS 客户端 |

## 替代方案

- **保留 Fastify**：MVP 更快，但扩展时缺少统一事务/安全/调度故事，与用户「后续升级与架构扩展」目标冲突。
- **NestJS**：与 React 栈 TS 统一，但 JVM 生态与企业集成非其强项；已否决。

## 测试

- JUnit 5 + `MockMvc` 切片/全上下文测试。
- Harness `init.*` 执行 `./gradlew test`；Foojay Toolchain 自动解析 JDK 17。

## 部署（规划）

- `bootJar` + Docker 多阶段构建（后续 change）；MVP 本地 `bootRun` 即可。
