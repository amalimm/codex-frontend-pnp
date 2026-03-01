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

usage() {
  cat <<'USAGE'
Usage: setup-codex.sh [--dry-run] [--no-backup]

Installs this repository's production Codex setup into:
  $CODEX_HOME (if set) or ~/.codex

Options:
  --dry-run    Print actions without changing files
  --no-backup  Skip backup of existing ~/.codex config/rules/skills
  -h, --help   Show this help
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

for required in "$SRC_CONFIG" "$SRC_RULES" "$SRC_SKILLS_DIR"; do
  if [[ ! -e "$required" ]]; then
    echo "Missing required source path: $required" >&2
    exit 1
  fi
done

if [[ "$NO_BACKUP" -eq 0 ]]; then
  if [[ -e "$TARGET_CONFIG" || -e "$TARGET_RULES" || -d "$TARGET_SKILLS_DIR" ]]; then
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
  Context7 MCP is configured but may fail until you export a valid key.
NOTE
fi

cat <<DONE

Done.
Installed:
  Config: $TARGET_CONFIG
  Rules:  $TARGET_RULES
  Skills: $TARGET_SKILLS_DIR

Recommended next steps:
  1) export CONTEXT7_API_KEY="<your-key>"
  2) Restart Codex
  3) Run: bash scripts/audit-codex.sh
DONE
