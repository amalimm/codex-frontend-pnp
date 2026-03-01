# React Stack 2026 (Default)

## Table of contents
- Principles
- Quick decision shortcuts
- Stack layers and choices
- Lean variants

## Principles
- Prefer React + TypeScript for AI-friendly, type-safe codebases.
- Keep the stack minimal; add layers only when they solve a real problem.
- Default to tools with strong TypeScript support and good ecosystem adoption.

## Quick decision shortcuts
- Need SSR/SSG/SEO or React Server Components: choose Next.js.
- Want Vite, explicit control, or no RSC requirement: choose TanStack Start.
- Heavy client data fetching and caching: use TanStack Query.
- Complex routing outside Next.js: use TanStack Router.
- Rich forms: use React Hook Form + Zod.
- Full-stack TypeScript API: use tRPC.
- Managed backend with Postgres and auth: use Supabase.
- Reactive backend with built-in vector and AI workflows: use Convex.

## Stack layers and choices

### Core
- React + TypeScript
  - Baseline for modern React apps; TypeScript improves refactors and AI output quality.

### Framework
- Next.js
  - Mature ecosystem, SSR/SSG, React Server Components, streaming.
- TanStack Start
  - More explicit control, Vite-based, strong types; RSC not production-ready.

### Styling
- Tailwind CSS
  - Utility-first, scalable, AI-friendly.

### UI components
- shadcn/ui
  - Components live in your repo and are fully editable.

### Data fetching
- TanStack Query
  - Caching, background refetching, and server state handling.

### Routing
- Next.js App Router (if using Next.js)
- TanStack Router (if Vite/TanStack Start)
  - Strong type safety for routes, params, and search.

### State management
- Zustand
  - Simple, low-boilerplate global state.
  - Omit if local component state or server state is enough.

### Forms
- React Hook Form
  - Minimal re-renders, strong integrations.
  - Omit if forms are minimal or use simple inputs.

### Validation
- Zod
  - Default TypeScript-first validation library.
  - Consider lighter alternatives only for strict bundle size needs.

### Type-safe APIs
- tRPC
  - Full-stack TypeScript contracts without manual REST schemas.

### Backend services
- Supabase
  - Postgres, auth, storage, realtime.
- Convex
  - Reactive queries, built-in AI/RAG and vector search.

### ORM
- Prisma
  - Schema-first, migrations, rich tooling.
- Drizzle
  - TypeScript-first SQL-like queries.

### Auth
- Better Auth
  - Framework-agnostic with passkeys, social login, and 2FA.

### Testing
- Vitest + React Testing Library + Playwright
  - Unit/integration + end-to-end coverage.

### AI SDK
- Vercel AI SDK
  - Streaming and multi-provider support; optional AI UI elements.
- TanStack AI
  - Strong types; emerging alternative.

### Animation
- Motion (formerly Framer Motion)
  - Declarative animation and layout transitions.

### Tables
- TanStack Table
  - Headless, typed tables for complex grids.

### Mobile
- React Native + Expo
  - Cross-platform, fast iteration and OTA updates.

### Component development
- Storybook
  - Isolated component dev and visual testing.

### AI-assisted development
- Builder.io
  - Visual editing tied to React components.
- Claude Code or Cursor
  - Agentic coding assistants.

## Lean variants
- Marketing site: Next.js + Tailwind; skip Zustand, tRPC, TanStack Query unless needed.
- Internal tool: TanStack Start + TanStack Query + TanStack Router + Tailwind + shadcn/ui.
- Data-heavy SaaS: Next.js + TanStack Query + TanStack Table + Zustand + tRPC + Zod.
- AI product: Add Vercel AI SDK and vector-capable backend (Supabase or Convex).
