# openspec/specs — 能力规格（长期记忆）

每个 **capability** 一个目录，内含 `spec.md`，描述该能力对外的契约（输入、输出、边界、错误语义）。

- 活跃变更在 `openspec/changes/<name>/` 起草；**归档**时 delta 合并到此处。
- 子代理实现前应阅读相关 `spec.md`。

## 规划中的能力域（尚未创建 spec）

| Capability | 说明 |
| --- | --- |
| `auth` | 注册、登录、会话 |
| `itinerary` | 行程 CRUD、天/站点编排 |
| `discovery` | 目的地与 POI 发现 |
| `collaboration` | 同行者邀请与权限 |

首个 spec 通常在第一次 `/opsx:archive` 后出现在此目录。
