import { describe, expect, it } from "vitest";
import { createHealthResponse } from "./index.js";

describe("createHealthResponse", () => {
  it("returns ok payload for a service name", () => {
    expect(createHealthResponse("chinatrip")).toEqual({
      ok: true,
      service: "chinatrip",
    });
  });
});
