#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

bash scripts/setup-codex.sh
bash scripts/audit-codex.sh

cat <<'DONE'

Clone-and-play setup complete.

Next:
  1) Restart Codex
  2) If Context7 fails, export CONTEXT7_API_KEY and rerun setup
DONE
