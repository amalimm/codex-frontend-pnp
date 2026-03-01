#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

SRC_CONFIG="$REPO_ROOT/.codex/config.toml"
SRC_RULES="$REPO_ROOT/.codex/rules/default.rules"
SRC_SKILLS_DIR="$REPO_ROOT/.codex/skills"

TARGET_CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
TARGET_CONFIG="$TARGET_CODEX_HOME/config.toml"
TARGET_RULES_DIR="$TARGET_CODEX_HOME/rules"
TARGET_RULES="$TARGET_RULES_DIR/default.rules"
TARGET_SKILLS_DIR="$TARGET_CODEX_HOME/skills"
TARGET_BACKUP_ROOT="$TARGET_CODEX_HOME/backups"

DRY_RUN=0
NO_BACKUP=0
RUN_SYNC=0
SYNC_ONLY=0

usage() {
  cat <<'USAGE'
Usage: clone-play.sh [--dry-run] [--no-backup] [--check-sync] [--check-sync-only]

Default behavior:
  1) Backup current ~/.codex config/rules/skills
  2) Install this repo's .codex config/rules/skills into ~/.codex
  3) Run safety audit

Options:
  --dry-run          Print install actions without changing files
  --no-backup        Skip backup before install
  --check-sync       Also compare repo .codex vs local ~/.codex
  --check-sync-only  Only run comparison (no install, no audit)
  -h, --help         Show this help
USAGE
}

run_cmd() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '[dry-run]'
    printf ' %q' "$@"
    echo
  else
    "$@"
  fi
}

is_private_state_path() {
  local p="$1"
  case "$p" in
    .codex/.personality_migration|.codex/auth.json|.codex/history.jsonl|.codex/models_cache.json|.codex/config.toml.bak|.codex/version.json|.codex/test_write)
      return 0
      ;;
    .codex/state_*.sqlite|.codex/state_*.sqlite-shm|.codex/state_*.sqlite-wal)
      return 0
      ;;
    .codex/sessions/*|.codex/tmp/*|.codex/log/*|.codex/shell_snapshots/*|.codex/archived_sessions/*|.codex/backups/*|.codex/vendor_imports/*)
      return 0
      ;;
  esac
  return 1
}

install_codex() {
  for required in "$SRC_CONFIG" "$SRC_RULES" "$SRC_SKILLS_DIR"; do
    if [[ ! -e "$required" ]]; then
      echo "Missing required source path: $required" >&2
      exit 1
    fi
  done

  if [[ "$NO_BACKUP" -eq 0 ]]; then
    if [[ -e "$TARGET_CONFIG" || -e "$TARGET_RULES" || -d "$TARGET_SKILLS_DIR" ]]; then
      local ts backup_dir
      ts="$(date +%Y%m%d-%H%M%S)"
      backup_dir="$TARGET_BACKUP_ROOT/$ts"
      echo "Creating backup at: $backup_dir"
      run_cmd mkdir -p "$backup_dir"

      if [[ -e "$TARGET_CONFIG" ]]; then
        run_cmd cp -a "$TARGET_CONFIG" "$backup_dir/config.toml"
      fi
      if [[ -e "$TARGET_RULES" ]]; then
        run_cmd mkdir -p "$backup_dir/rules"
        run_cmd cp -a "$TARGET_RULES" "$backup_dir/rules/default.rules"
      fi
      if [[ -d "$TARGET_SKILLS_DIR" ]]; then
        run_cmd cp -a "$TARGET_SKILLS_DIR" "$backup_dir/skills"
      fi
    fi
  fi

  echo "Installing config and rules to: $TARGET_CODEX_HOME"
  run_cmd mkdir -p "$TARGET_RULES_DIR" "$TARGET_SKILLS_DIR"
  run_cmd cp -a "$SRC_CONFIG" "$TARGET_CONFIG"
  run_cmd cp -a "$SRC_RULES" "$TARGET_RULES"

  echo "Installing managed skills"
  shopt -s dotglob nullglob
  for skill_dir in "$SRC_SKILLS_DIR"/*; do
    [[ -d "$skill_dir" ]] || continue
    local skill_name target_skill
    skill_name="$(basename "$skill_dir")"
    target_skill="$TARGET_SKILLS_DIR/$skill_name"
    run_cmd rm -rf "$target_skill"
    run_cmd cp -a "$skill_dir" "$target_skill"
    echo "  - $skill_name"
  done
  shopt -u dotglob nullglob

  if [[ -z "${CONTEXT7_API_KEY:-}" ]]; then
    cat <<'NOTE'

NOTE:
  CONTEXT7_API_KEY is not set in your shell environment.
  Context7 MCP may fail until you export a valid key.
NOTE
  fi
}

audit_codex() {
  local failures=0

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

  echo "Auditing Codex setup"
  echo "Target CODEX_HOME: $TARGET_CODEX_HOME"

  check_file "$TARGET_CONFIG"
  check_file "$TARGET_RULES"
  check_file "$SRC_SKILLS_DIR"

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
  fi

  if [[ -d "$SRC_SKILLS_DIR" ]]; then
    local skill_count
    skill_count="$(find "$SRC_SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
    if [[ "$skill_count" -ge 12 ]]; then
      pass "Repo skills count: $skill_count"
    else
      fail "Repo skills count too low: $skill_count"
    fi
  fi

  if rg -n '(ctx7sk-|sk-[A-Za-z0-9]{20,}|API_KEY\s*=\s*"[^$][^"]+")' "$REPO_ROOT/.codex" >/dev/null 2>&1; then
    fail "Potential hardcoded secrets found in tracked .codex files"
  else
    pass "No hardcoded API key patterns detected in tracked .codex files"
  fi

  if [[ "$failures" -gt 0 ]]; then
    echo ""
    echo "Audit completed with $failures failure(s)."
    return 1
  fi

  echo ""
  echo "Audit completed successfully."
  return 0
}

sync_report() {
  local tmp_identical tmp_different tmp_missing tmp_repo tmp_local tmp_local_only tmp_non_private
  tmp_identical="$(mktemp)"
  tmp_different="$(mktemp)"
  tmp_missing="$(mktemp)"
  tmp_repo="$(mktemp)"
  tmp_local="$(mktemp)"
  tmp_local_only="$(mktemp)"
  tmp_non_private="$(mktemp)"

  local total=0 identical=0 different=0 missing=0 local_only=0 private_only=0 non_private_only=0

  while IFS= read -r repo_file; do
    local local_file
    total=$((total + 1))
    local_file="$TARGET_CODEX_HOME/${repo_file#.codex/}"

    if [[ ! -f "$local_file" ]]; then
      echo "$repo_file" >> "$tmp_missing"
      missing=$((missing + 1))
      continue
    fi

    if cmp -s "$REPO_ROOT/$repo_file" "$local_file"; then
      echo "$repo_file" >> "$tmp_identical"
      identical=$((identical + 1))
    else
      echo "$repo_file" >> "$tmp_different"
      different=$((different + 1))
    fi
  done < <(git -C "$REPO_ROOT" ls-files .codex | sort)

  git -C "$REPO_ROOT" ls-files .codex | sort > "$tmp_repo"
  if [[ -d "$TARGET_CODEX_HOME" ]]; then
    find "$TARGET_CODEX_HOME" -type f | sed "s#^$TARGET_CODEX_HOME/#.codex/#" | sort > "$tmp_local"
    comm -23 "$tmp_local" "$tmp_repo" > "$tmp_local_only"
  fi

  if [[ -s "$tmp_local_only" ]]; then
    while IFS= read -r p; do
      local_only=$((local_only + 1))
      if is_private_state_path "$p"; then
        private_only=$((private_only + 1))
      else
        non_private_only=$((non_private_only + 1))
        echo "$p" >> "$tmp_non_private"
      fi
    done < "$tmp_local_only"
  fi

  echo ""
  echo "Managed parity check (repo .codex vs $TARGET_CODEX_HOME)"
  echo "- tracked files: $total"
  echo "- identical: $identical"
  echo "- different: $different"
  echo "- missing: $missing"
  echo "- local-only files: $local_only"
  echo "- local-only private/runtime: $private_only"
  echo "- local-only non-private: $non_private_only"

  if [[ -s "$tmp_different" ]]; then
    echo ""
    echo "Different tracked files:"
    sed 's/^/- /' "$tmp_different"
  fi

  if [[ -s "$tmp_missing" ]]; then
    echo ""
    echo "Missing tracked files on local:"
    sed 's/^/- /' "$tmp_missing"
  fi

  if [[ -s "$tmp_non_private" ]]; then
    echo ""
    echo "Local-only non-private files:"
    sed 's/^/- /' "$tmp_non_private"
  fi

  rm -f "$tmp_identical" "$tmp_different" "$tmp_missing" "$tmp_repo" "$tmp_local" "$tmp_local_only" "$tmp_non_private"

  if [[ "$different" -gt 0 || "$missing" -gt 0 || "$non_private_only" -gt 0 ]]; then
    echo ""
    echo "[WARN] Repo .codex is not fully identical to local managed files."
    return 1
  fi

  echo ""
  echo "[PASS] Repo .codex matches local managed files (private/runtime files excluded)."
  return 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --no-backup)
      NO_BACKUP=1
      shift
      ;;
    --check-sync)
      RUN_SYNC=1
      shift
      ;;
    --check-sync-only)
      SYNC_ONLY=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ "$SYNC_ONLY" -eq 1 ]]; then
  sync_report
  exit $?
fi

install_codex
audit_codex

if [[ "$RUN_SYNC" -eq 1 ]]; then
  sync_report
fi

cat <<'DONE'

Clone-and-play setup complete.

Next:
  1) Restart Codex
  2) If Context7 fails, export CONTEXT7_API_KEY and rerun this script
DONE
