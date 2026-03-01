# Frontend Codex Skills + MCP Stack (Research)

Last updated: March 1, 2026

This is a practical shortlist of Codex skills and MCP servers that are high-leverage for frontend engineering workflows.

## 1) High-Value Skills To Add Next

These are from OpenAI's curated skills catalog and map directly to frontend daily work.

### Priority A

- `playwright`
  - Why: browser flow automation, UI debugging, snapshots, e2e assist.
  - Install: `$skill-installer playwright`
- `figma`
  - Why: fetch design context, assets, and variables from Figma during implementation.
  - Install: `$skill-installer figma`
- `figma-implement-design`
  - Why: design-to-code workflows with higher visual fidelity.
  - Install: `$skill-installer figma-implement-design`
- `gh-fix-ci`
  - Why: speed up failed CI diagnosis and fix loops.
  - Install: `$skill-installer gh-fix-ci`
- `gh-address-comments`
  - Why: close PR review comments faster with structured response loops.
  - Install: `$skill-installer gh-address-comments`

### Priority B

- `sentry`
  - Why: production issue triage and release health context.
  - Install: `$skill-installer sentry`
- `linear`
  - Why: issue planning and execution context directly in Codex tasks.
  - Install: `$skill-installer linear`
- `openai-docs`
  - Why: grounded OpenAI/Codex/API guidance from official docs.
  - Install: `$skill-installer openai-docs`
- `screenshot`
  - Why: quick visual capture and reporting while debugging UI defects.
  - Install: `$skill-installer screenshot`

### Deployment Pick-One

- `vercel-deploy` or `netlify-deploy` or `cloudflare-deploy`
  - Why: environment-specific deployment workflows.
  - Install examples:
    - `$skill-installer vercel-deploy`
    - `$skill-installer netlify-deploy`
    - `$skill-installer cloudflare-deploy`

## 2) Recommended MCP Servers For Frontend Work

Codex supports both stdio and streamable HTTP MCP servers via `codex mcp add` or `config.toml`.

### Core MCPs

- `context7` (already in your setup)
  - Purpose: up-to-date library and framework docs.
  - Add: `codex mcp add context7 -- npx -y @upstash/context7-mcp`
- `playwright`
  - Purpose: browser automation for flow testing and debugging.
  - Add: `codex mcp add playwright -- npx @playwright/mcp@latest`
- `chrome-devtools`
  - Purpose: deep runtime debugging and performance traces.
  - Add: `codex mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest`
- `figma` (remote)
  - Purpose: design context directly from Figma.
  - Add: `codex mcp add figma --url https://mcp.figma.com/mcp`
- `linear` (remote)
  - Purpose: issue context and ticket updates from Codex.
  - Add: `codex mcp add linear --url https://mcp.linear.app/mcp`

### Optional MCPs

- `storybook-mcp` (project local, via addon)
  - Purpose: expose component stories and docs as MCP tools.
  - Add addon: `npx storybook add @storybook/addon-mcp`
  - Endpoint when Storybook runs: `http://localhost:6006/mcp`
- `netlify` (if deploying on Netlify)
  - Purpose: deploy and manage Netlify resources from agent workflows.
  - Add: `codex mcp add netlify -- npx -y @netlify/mcp`
- `sentry`
  - Purpose: production error triage from agent context.
  - Notes: official remote service and self-host or stdio options are available in Sentry MCP docs.
- `github`
  - Purpose: PR and issue workflows beyond local git tooling.
  - Notes: official GitHub MCP server has remote and local options.

## 3) Suggested Codex Config Patterns

Use least-privilege and explicit enablement, especially for write-capable MCPs.

```toml
[mcp_servers.playwright]
command = "npx"
args = ["@playwright/mcp@latest"]
enabled = true
required = false

[mcp_servers.chrome_devtools]
command = "npx"
args = ["-y", "chrome-devtools-mcp@latest"]
enabled = true
required = false
# Optional scope hardening:
# enabled_tools = ["open", "screenshot", "console"]

[mcp_servers.figma]
url = "https://mcp.figma.com/mcp"
bearer_token_env_var = "FIGMA_OAUTH_TOKEN"
enabled = true
required = false

[mcp_servers.linear]
url = "https://mcp.linear.app/mcp"
enabled = true
required = false
```

## 4) Quick Rollout Plan

1. Install Priority A skills.
2. Enable `playwright`, `chrome-devtools`, `figma`, and `linear` MCPs.
3. Add `storybook` MCP in repos that already run Storybook.
4. Add `sentry` and deployment MCP only when corresponding service is used by the project.
5. Keep secrets in env vars, never in committed config.

## 5) Notes On X/Twitter Signal

I checked web and X-linked discovery paths. Signal quality is noisy and often secondary or aggregated. Recommendations above are based on primary sources (official docs, official repos, package metadata).

## Sources

- OpenAI Codex MCP docs: https://developers.openai.com/codex/mcp/
- OpenAI Codex Skills docs: https://developers.openai.com/codex/skills
- OpenAI skills catalog repo: https://github.com/openai/skills
- OpenAI curated skills: https://github.com/openai/skills/tree/main/skills/.curated
- Playwright MCP (official): https://github.com/microsoft/playwright-mcp
- Chrome DevTools MCP (official): https://github.com/ChromeDevTools/chrome-devtools-mcp
- Storybook MCP repo: https://github.com/storybookjs/mcp
- Storybook addon page: https://storybook.js.org/addons/%40storybook/addon-mcp
- Figma MCP docs: https://developers.figma.com/docs/figma-mcp-server
- Figma remote server docs: https://developers.figma.com/docs/figma-mcp-server/remote-server-installation/
- Figma desktop server docs: https://developers.figma.com/docs/figma-mcp-server/local-server-installation/
- Linear Codex MCP integration: https://linear.app/integrations/codex-mcp
- Netlify MCP docs: https://docs.netlify.com/welcome/build-with-ai/netlify-mcp-server/
- Netlify MCP repo: https://github.com/netlify/netlify-mcp
- Sentry MCP repo: https://github.com/getsentry/sentry-mcp
- GitHub MCP repo: https://github.com/github/github-mcp-server
