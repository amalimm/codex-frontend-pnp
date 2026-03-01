#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

TARGET_CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
TARGET_CONFIG="$TARGET_CODEX_HOME/config.toml"
TARGET_RULES="$TARGET_CODEX_HOME/rules/default.rules"
REPO_SKILLS_DIR="$REPO_ROOT/.codex/skills"

failures=0

pass() { echo "[PASS] $*"; }
fail() { echo "[FAIL] $*"; failures=$((failures + 1)); }

check_file() {
  local path="$1"
  if [[ -e "$path" ]]; then
    pass "Found: $path"
  else
    fail "Missing: $path"
  fi
}

echo "Auditing Codex production setup"
echo "Target CODEX_HOME: $TARGET_CODEX_HOME"

check_file "$TARGET_CONFIG"
check_file "$TARGET_RULES"
check_file "$REPO_SKILLS_DIR"

if [[ -f "$TARGET_CONFIG" ]]; then
  rg -q '^approval_policy = "on-request"' "$TARGET_CONFIG" \
    && pass "approval_policy is on-request" \
    || fail "approval_policy is not on-request"
  rg -q '^sandbox_mode = "workspace-write"' "$TARGET_CONFIG" \
    && pass "sandbox_mode is workspace-write" \
    || fail "sandbox_mode is not workspace-write"
  rg -q '^\[mcp_servers.context7\]' "$TARGET_CONFIG" \
    && pass "context7 MCP configured" \
    || fail "context7 MCP missing"
fi

if [[ -f "$TARGET_RULES" ]]; then
  rg -q 'prefix_rule\(pattern=\["rm", "-rf"\], decision="prompt"\)' "$TARGET_RULES" \
    && pass "rm -rf requires prompt" \
    || fail "rm -rf is not guarded"
  rg -q 'prefix_rule\(pattern=\["bash", "-lc"\], decision="prompt"\)' "$TARGET_RULES" \
    && pass "bash -lc requires prompt" \
    || fail "bash -lc is not guarded"
  if rg -q 'decision="allow"' "$TARGET_RULES"; then
    pass "Allow rules exist (expected for read-only commands)"
  else
    fail "No allow rules found"
  fi
fi

if [[ -d "$REPO_SKILLS_DIR" ]]; then
  skill_count="$(find "$REPO_SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
  if [[ "$skill_count" -ge 12 ]]; then
    pass "Repo skills count: $skill_count"
  else
    fail "Repo skills count too low: $skill_count"
  fi
fi

# Secret scan on tracked setup files.
if rg -n '(ctx7sk-|sk-[A-Za-z0-9]{20,}|API_KEY\s*=\s*"[^$][^"]+")' "$REPO_ROOT/.codex" >/dev/null 2>&1; then
  fail "Potential hardcoded secrets found in repo setup files"
else
  pass "No hardcoded API key patterns detected in repo setup files"
fi

if [[ "$failures" -gt 0 ]]; then
  echo ""
  echo "Audit completed with $failures failure(s)."
  exit 1
fi

echo ""
echo "Audit completed successfully."
