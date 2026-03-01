# codex-frontend-pnp

Portable Codex setup for frontend engineers. Clone this repo on a new machine and bootstrap your `.codex` workspace quickly with reusable skills, rules, and a safe config template.

## What This Repo Includes

- Shareable `.codex` starter files
- 12 frontend-oriented local skills
- Command allowlist baseline in `.codex/rules/default.rules`
- Sanitized config template in `.codex/config.template.toml`
- Skill documentation in `.codex/skills/README.md`

## What This Repo Intentionally Excludes

- Secrets and tokens (`auth.json`, API keys)
- Session/history/state databases
- Machine-specific trusted path entries

## Quick Start (New Machine)

1. Clone this repository.
2. Create a backup of your existing local Codex folder (if any):

```bash
cp -R ~/.codex ~/.codex.backup.$(date +%Y%m%d-%H%M%S)
```

3. Copy starter files from this repo:

```bash
mkdir -p ~/.codex
cp -R .codex/skills ~/.codex/
mkdir -p ~/.codex/rules
cp .codex/rules/default.rules ~/.codex/rules/default.rules
cp .codex/config.template.toml ~/.codex/config.toml
```

If you already have `~/.codex/config.toml`, merge manually instead of overwriting it.

4. Set secrets/environment variables (for example Context7):

```bash
export CONTEXT7_API_KEY="<your-context7-key>"
```

5. Restart Codex.

## Recommended Optional Curated Skills (Checked March 1, 2026)

These are from the current `openai/skills` curated list and are especially useful for frontend workflows:

- `playwright`: browser automation/e2e flows
- `figma`: design context retrieval
- `figma-implement-design`: design-to-code handoff
- `vercel-deploy` (or `netlify-deploy` / `cloudflare-deploy`): deployment workflows
- `sentry`: error/performance observability
- `openai-docs`: official OpenAI docs grounding
- `gh-fix-ci` and `gh-address-comments`: CI + PR feedback loops
- `screenshot`: visual capture/reporting in debugging flows

Note: the `skills/.experimental` endpoint returned 404 at check time (March 1, 2026).

Install curated skills with Codex `skill-installer`, for example:

```text
$skill-installer playwright
$skill-installer figma
$skill-installer sentry
```

## Deferred Integration

- Pencil MCP is intentionally skipped for now and can be added later after provenance verification.

## Repo Layout

- `.codex/config.template.toml`
- `.codex/rules/default.rules`
- `.codex/skills/`
- `.codex/skills/README.md`
