---
name: project-stack-selector
description: Select and recommend a modern React + TypeScript stack for new project setup, architecture design, or implementation planning. Use when asked which stack/framework/libraries/services to choose for a web app, SaaS, internal tool, or AI-enabled product, or when defining a baseline tech stack. Use when user starts a new project or implementing architecture design decision in which this file can be referenced for modern technology stacks.
---

# Project Stack Selector

## Overview
Provide a decision-driven stack recommendation centered on React + TypeScript. Default to the 2026 React stack reference and adapt based on project constraints and goals.

## Workflow

### 1) Gather requirements
Ask concise, high-signal questions (2-5):
- Project type (marketing site, SaaS, internal tool, data-heavy app, AI feature, mobile)
- Need for SSR/SSG, SEO, streaming, or React Server Components
- Data complexity (real-time, caching, offline, heavy tables)
- Backend preference (managed backend vs custom API; Postgres vs serverless)
- Deployment constraints (Vercel, self-hosted, edge)
- Team preferences or existing constraints

If the user explicitly wants non-React or another framework, confirm and pause recommendations.

### 2) Choose the framework
Use:
- Next.js when SSR/SSG/SEO, RSC/streaming, or a large ecosystem matters.
- TanStack Start when you want explicit control, a Vite-based stack, lighter framework behavior, or no RSC requirement.

If unsure, default to Next.js and note why.

### 3) Assemble the stack
Read `references/react-stack-2026.md` for default layers, options, and selection heuristics. Keep only the layers needed for the project; avoid adding tools without a clear need.

### 4) Present the recommendation
Return:
- A short "Recommended Stack" list grouped by layer
- 2-5 bullets explaining tradeoffs
- "Open Questions" (if any) and what would change the choice
- "Next Steps" (initial setup tasks)

### 5) Follow-ups
Offer to tailor for cost, scale, enterprise auth, analytics, or infra.

## References

- `references/react-stack-2026.md` - default stack layers, options, and selection heuristics
