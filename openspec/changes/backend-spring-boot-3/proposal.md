# Proposal: 后端迁移至 Spring Boot 3

## 问题

原 Fastify（Node/TS）适合 MVP 速度，但在鉴权、事务、复杂领域建模、企业级集成与长期团队扩展上，需要更可演进的 JVM 后端基线。

## 方案

将 `backend/` 子模块替换为 **Spring Boot 3.4 + Java 17 + Gradle**，保留 `GET /health` 与 `packages/shared` 中 `healthSchema` 的 JSON 契约；Harness 文档与 `init.*` 纳入 Gradle 测试。

## 非目标

- 本变更不引入 PostgreSQL / JPA / Spring Security（后续 change）。
- 不删除 `packages/shared`；Web 仍用 Zod，API 用 Java DTO 对齐。
- 不做微服务拆分。

## 成功标准

`./init.ps1` 通过：pnpm 测试绿 + `backend` 下 `gradlew test` 绿，且 `/health` JSON 与 shared 契约一致。
