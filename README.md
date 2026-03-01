# codex-frontend-pnp

Production-ready, plug-and-play Codex setup for frontend engineers.

## What This Gives You

- Managed skills in official project layout: `.agents/skills/`
- Safe default user config: `.codex/config.toml`
- Hardened command approval baseline: `.codex/rules/default.rules`
- One-command installer: `scripts/setup-codex.sh`
- Post-install safety audit: `scripts/audit-codex.sh`

## One-Command Setup

```bash
bash scripts/setup-codex.sh
```

What the setup script does:

1. Backs up existing `~/.codex` config/rules/skills into `~/.codex/backups/<timestamp>/`
2. Installs this repo's config and rules into `~/.codex/`
3. Installs managed skills into `~/.codex/skills/`

Script options:

- `--dry-run`: preview actions without changes
- `--no-backup`: skip backup step

## Safety Defaults

Installed config defaults:

- `approval_policy = "on-request"`
- `sandbox_mode = "workspace-write"`
- Context7 MCP configured and pinned to `@upstash/context7-mcp@2.1.2`

Installed rules defaults:

- Read-only commands are `allow`
- Shell wrappers, package managers, and mutating commands are `prompt`
- Explicitly guarded: `rm -rf`, `rm -f`, `bash -lc`, package install tools

Run safety verification:

```bash
bash scripts/audit-codex.sh
```

## Included Managed Skills

- `context7-library-refs`
- `conventional-commits`
- `frontend-testing`
- `general-coding-standards`
- `payload-cms`
- `planning-with-files`
- `project-stack-selector`
- `react-best-practices`
- `react-code-fix-linter`
- `seo-review`
- `ui-ux-pro-max`
- `web-design-guidelines`

## Recommended Add-Ons To Install

Curated skills:

- `playwright`
- `figma`
- `figma-implement-design`
- `gh-fix-ci`
- `gh-address-comments`
- `openai-docs`
- `sentry`
- `linear`
- Choose deploy workflow: `vercel-deploy` or `netlify-deploy` or `cloudflare-deploy`

Install example:

```text
$skill-installer playwright
$skill-installer figma
$skill-installer sentry
```

MCP add-ons for frontend workflows:

- `codex mcp add playwright -- npx @playwright/mcp@latest`
- `codex mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest`
- `codex mcp add figma --url https://mcp.figma.com/mcp`
- `codex mcp add linear --url https://mcp.linear.app/mcp`

Optional:

- Storybook MCP (`@storybook/addon-mcp`, endpoint `http://localhost:6006/mcp`)
- Netlify MCP (`codex mcp add netlify -- npx -y @netlify/mcp`)
- GitHub MCP (official remote/local options)
- Sentry MCP (`https://mcp.sentry.dev`)

Pencil MCP remains intentionally excluded.

## Repo Layout

- `.agents/skills/`
- `.codex/config.toml`
- `.codex/rules/default.rules`
- `scripts/setup-codex.sh`
- `scripts/audit-codex.sh`
- `.gitignore`
- `README.md`

## Sources

- https://developers.openai.com/codex/skills
- https://developers.openai.com/codex/mcp/
- https://developers.openai.com/codex/config-reference
- https://github.com/openai/skills/tree/main/skills/.curated
- https://github.com/microsoft/playwright-mcp
- https://github.com/ChromeDevTools/chrome-devtools-mcp
- https://developers.figma.com/docs/figma-mcp-server/remote-server-installation/
- https://linear.app/integrations/codex-mcp
- https://github.com/github/github-mcp-server
- https://github.com/getsentry/sentry-mcp
