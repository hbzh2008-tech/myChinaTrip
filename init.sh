#!/usr/bin/env bash
#
# init.sh — single entry point for project bootstrap + verification.

set -e

cd "$(dirname "$0")"

echo "=== Harness Initialization (ChinaTrip) ==="

if [ ! -f "openspec/config.yaml" ]; then
  echo "✗ openspec/config.yaml not found — not in project root?" >&2
  exit 1
fi
echo "✓ project root confirmed"

if ! command -v openspec >/dev/null 2>&1; then
  echo "✗ openspec CLI not installed. See README.md prerequisites." >&2
  exit 1
fi
echo "✓ openspec $(openspec --version)"

echo
echo "=== Active OpenSpec changes ==="
openspec list || true

echo
echo "=== Install + typecheck + test (Node) ==="
if ! command -v pnpm >/dev/null 2>&1; then
  echo "✗ pnpm not installed. See README.md (corepack enable)." >&2
  exit 1
fi
pnpm install
pnpm typecheck
pnpm test

echo
echo "=== Backend test (Spring Boot / Gradle) ==="
if [ ! -f "backend/gradlew" ]; then
  echo "✗ backend/gradlew not found — submodule initialized?" >&2
  exit 1
fi
( cd backend && ./gradlew test )

echo
echo "=== Verification complete ==="
echo
echo "Next steps:"
echo "  1. openspec list              — see active changes"
echo "  2. /opsx:propose <description> — start a new change"
echo "  3. /opsx:apply <name>          — refine + build via Superpowers"
