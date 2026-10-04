# CONVENTIONS.md

## 工具链

| 工具 | 命令 |
| --- | --- |
| 安装 | `pnpm install`（根目录） |
| 类型检查 | `pnpm typecheck` |
| 测试 | `pnpm test` |
| 开发（Web） | `pnpm dev` |
| 开发（API） | `pnpm dev:api` 或 `backend/` 下 `gradlew bootRun` |
| API 测试 | `pnpm test:api` 或 `./init.ps1` |
| 基线验证 | `./init.ps1` 或 `./init.sh` |
| OpenSpec | `openspec list` |

## 命名

- 包名：`@chinatrip/<app|shared>`
- 文件：`kebab-case.ts` / React 组件 `PascalCase.tsx`
- 函数/变量：`camelCase`；常量 `UPPER_SNAKE_CASE`
- 测试：与源文件同目录或 `*.test.ts`

## 导入和模块边界

- 使用 ESM（`"type": "module"`）。
- Web 内可用 `@/*` 路径别名（见 `apps/web/tsconfig.json`）。
- 跨 app 共享类型只从 `@chinatrip/shared` 导入。

## 测试

- 默认 TDD（Superpowers 工作流）；单元测试用 Vitest。
- 集成测试目录（未来）：`backend/src/test/java/` 下 `*IntegrationTest`。
- 测试名：`describe` + `it('should ...')` 或 `test_<动作>_<条件>_<期望>`。

## 提交信息

- Conventional Commits：`feat:` / `fix:` / `chore:` / `docs:` / `test:` / `refactor:`
- 主题 ≤ 72 字符，祈使语气
- 正文说明 **why**；关联 OpenSpec change：`Change: <change-name>`

## PR / Code Review

- 功能 PR 对应一个 OpenSpec change
- 描述链接 `openspec/changes/<name>/proposal.md`
- 改动应能映射到 `tasks.md` 中的任务

## 错误处理

- API：`@RestControllerAdvice` 映射为统一 JSON（首个 API change 定义 shape）
- 禁止空 `catch`；日志用 SLF4J（Logback 默认）

## 日志

- API：Spring Boot 默认 Logback；生产环境 JSON 布局在首个部署 change 引入
- Web：生产环境避免 `console.log` 泄露 PII
