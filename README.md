# codex-frontend-pnp

Very easy clone-and-play Codex setup for frontend engineering.

## Quick Start

```bash
git clone https://github.com/amalimm/codex-frontend-pnp.git
cd codex-frontend-pnp
export CONTEXT7_API_KEY="<your-key>"   # optional but recommended
bash scripts/clone-play.sh
```

That is it. The script installs this repo into `~/.codex`, runs a safety audit, and prints next steps.

## What Gets Installed

- `.codex/config.toml` -> `~/.codex/config.toml`
- `.codex/rules/default.rules` -> `~/.codex/rules/default.rules`
- `.codex/skills/*` -> `~/.codex/skills/*`

Before overwrite, existing local config/rules/skills are backed up to:

- `~/.codex/backups/<timestamp>/`

## Repo Structure (Matches Local Layout)

- `.codex/config.toml`
- `.codex/rules/default.rules`
- `.codex/skills/`
- `scripts/clone-play.sh`
- `scripts/setup-codex.sh`
- `scripts/audit-codex.sh`

## Safety Rules

This repo intentionally does **not** track local runtime/private files such as:

- `auth.json`, `history.jsonl`, `models_cache.json`
- `state_*.sqlite*`, logs, sessions, tmp, shell snapshots, archived sessions

The audit script also checks for hardcoded key patterns in tracked `.codex` files.

Run manually anytime:

```bash
bash scripts/audit-codex.sh
```

## Update Flow

```bash
cd codex-frontend-pnp
git pull
bash scripts/clone-play.sh
```

## Optional Frontend Add-Ons

- `playwright`
- `figma`
- `figma-implement-design`
- `openai-docs`
- `sentry`
- `linear`

Example:

```text
$skill-installer playwright
$skill-installer figma
$skill-installer sentry
```
