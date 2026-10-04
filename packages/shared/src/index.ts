import { z } from "zod";

/** 健康检查响应 — Web 与 API 共用契约（Java 侧见 backend HealthResponse） */
export const healthSchema = z.object({
  ok: z.literal(true),
  service: z.string(),
});

export type HealthResponse = z.infer<typeof healthSchema>;

export function createHealthResponse(service: string): HealthResponse {
  return healthSchema.parse({ ok: true, service });
}
