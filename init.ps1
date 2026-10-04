# init.ps1 — Windows 基线检查（Harness 入口）
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host "=== Harness Initialization (ChinaTrip) ==="

if (-not (Test-Path "openspec/config.yaml")) {
    Write-Error "openspec/config.yaml not found — not in project root?"
}
Write-Host "✓ project root confirmed"

$openspec = Get-Command openspec -ErrorAction SilentlyContinue
if (-not $openspec) {
    Write-Error "openspec CLI not installed. See README.md prerequisites."
}
Write-Host "✓ openspec $(openspec --version)"

Write-Host ""
Write-Host "=== Active OpenSpec changes ==="
openspec list

Write-Host ""
Write-Host "=== Install + typecheck + test ==="
if (-not (Get-Command pnpm -ErrorAction SilentlyContinue)) {
    Write-Error "pnpm not installed. Enable via corepack: corepack enable && corepack prepare pnpm@9.15.0 --activate"
}
pnpm install
pnpm typecheck
pnpm test

Write-Host ""
Write-Host "=== Verification complete ==="
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. openspec list"
Write-Host "  2. /opsx:propose <description>"
Write-Host "  3. /opsx:apply <name>"
