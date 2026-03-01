# Skills Index

This folder contains reusable Codex skills for a frontend-engineer workflow.
Each skill is self-contained and starts with a `SKILL.md` trigger/workflow file.

## Included Skills

| Skill Folder | What It Solves | Typical Triggers | Dependencies / Notes |
|---|---|---|---|
| `context7-library-refs` | Keeps library/framework usage grounded in current docs | "how to use X SDK", "show API call" | Requires Context7 MCP and API key |
| `conventional-commits` | Consistent high-quality commit messages | "write commit message", "commit this" | Works with local git context |
| `frontend-testing` | Vitest + React Testing Library test generation/review | "write tests", "improve coverage" | Tuned for frontend component/hook tests |
| `general-coding-standards` | Baseline coding quality and maintainability | write/refactor/review requests | Language-agnostic standards |
| `payload-cms` | Payload CMS fields/hooks/access/query patterns | payload config/debug issues | Focused on Payload/Next.js stacks |
| `planning-with-files` | Persistent markdown planning for complex tasks | multi-step tasks, long research | Creates `task_plan.md`, `findings.md`, `progress.md` |
| `project-stack-selector` | Modern React + TypeScript stack decisions | "what stack should I use" | Includes 2026 reference material |
| `react-best-practices` | Vercel-focused React/Next.js performance rules | optimize, refactor, performance reviews | Large ruleset under `rules/` |
| `react-code-fix-linter` | Quick lint/format fix flow before merge | "fix lint", "cleanup before commit" | Runs formatter/linter commands |
| `seo-review` | Structured SEO audits for docs/content pages | "review SEO", "improve title/meta" | Includes checklists/templates |
| `ui-ux-pro-max` | UI/UX style and implementation guidance | design/review/improve UI requests | Uses bundled scripts/data |
| `web-design-guidelines` | Audits UI code against web interface guidelines | "review my UI", "check accessibility" | Fetches guidelines source per audit |

## Skill Anatomy

Most skills follow this structure:

- `SKILL.md`: trigger metadata + workflow
- `references/`: optional detailed docs loaded only when needed
- `scripts/`: optional deterministic helpers
- `assets/`: optional templates/static resources

## Frontend Daily-Driver Suggestions

For typical frontend work, the most commonly useful default set is:

- `context7-library-refs`
- `react-best-practices`
- `frontend-testing`
- `web-design-guidelines`
- `general-coding-standards`
- `conventional-commits`
