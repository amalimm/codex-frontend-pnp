# codex-frontend-pnp

Portable Codex frontend setup. Clone this repo and start with repo-local skills using the official Codex project structure.

Checked against official docs on March 1, 2026.

## Official Structure

This repo follows the Codex skill layout:

- `.agents/skills/<skill-name>/SKILL.md` (required)
- Optional skill folders: `references/`, `scripts/`, `assets/`

Template user config is kept separately:

- `.codex/config.template.toml` (safe template)
- `.codex/rules/default.rules` (optional local approval baseline)

## Included Skills

- `context7-library-refs`: doc-grounded library/framework API usage
- `conventional-commits`: structured Conventional Commits
- `frontend-testing`: Vitest + RTL testing workflows
- `general-coding-standards`: baseline coding quality standards
- `payload-cms`: Payload CMS implementation/debug patterns
- `planning-with-files`: file-based planning for complex tasks
- `project-stack-selector`: modern React/TS stack selection
- `react-best-practices`: Vercel React/Next performance rules
- `react-code-fix-linter`: lint/format cleanup flow
- `seo-review`: SEO audits for docs/content pages
- `ui-ux-pro-max`: UI/UX design/build guidance
- `web-design-guidelines`: UI/accessibility guideline review

## Quick Start

1. Clone the repo and work from this project.
2. Repo-local skills under `.agents/skills` are available automatically in this project context.
3. (Optional) copy template config into your user config:

```bash
mkdir -p ~/.codex/rules
cp .codex/rules/default.rules ~/.codex/rules/default.rules
cp .codex/config.template.toml ~/.codex/config.toml
```

If `~/.codex/config.toml` already exists, merge manually instead of overwriting.

4. Set required environment values (example):

```bash
export CONTEXT7_API_KEY="<your-context7-key>"
```

## Frontend Add-Ons (Curated Skills)

Recommended installs from `openai/skills` curated catalog:

- `playwright`
- `figma`
- `figma-implement-design`
- `gh-fix-ci`
- `gh-address-comments`
- `sentry`
- `linear`
- `openai-docs`
- Pick one deploy skill: `vercel-deploy` or `netlify-deploy` or `cloudflare-deploy`

Install examples:

```text
$skill-installer playwright
$skill-installer figma
$skill-installer sentry
```

## MCP Recommendations (Frontend)

Core:

- `context7`: `codex mcp add context7 -- npx -y @upstash/context7-mcp`
- `playwright`: `codex mcp add playwright -- npx @playwright/mcp@latest`
- `chrome-devtools`: `codex mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest`
- `figma` (remote): `codex mcp add figma --url https://mcp.figma.com/mcp`
- `linear` (remote): `codex mcp add linear --url https://mcp.linear.app/mcp`

Optional:

- Storybook MCP (`@storybook/addon-mcp`, endpoint `http://localhost:6006/mcp`)
- Netlify MCP (`codex mcp add netlify -- npx -y @netlify/mcp`)
- Sentry MCP
- GitHub MCP

Pencil MCP is intentionally skipped for now.

## Project Layout

- `.agents/skills/`
- `.codex/config.template.toml`
- `.codex/rules/default.rules`
- `.gitignore`
- `README.md`

## Sources

- https://developers.openai.com/codex/skills
- https://developers.openai.com/codex/mcp/
- https://github.com/openai/skills/tree/main/skills/.curated
- https://github.com/microsoft/playwright-mcp
- https://github.com/ChromeDevTools/chrome-devtools-mcp
- https://github.com/storybookjs/mcp
- https://developers.figma.com/docs/figma-mcp-server
- https://linear.app/integrations/codex-mcp
- https://docs.netlify.com/welcome/build-with-ai/netlify-mcp-server/
