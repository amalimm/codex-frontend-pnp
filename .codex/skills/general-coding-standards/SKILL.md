---
name: general-coding-standards
description: Language-agnostic coding standards and best practices. Use when asked to write, refactor, or review code to enforce clarity, consistency, modular design, testing, error handling, security, and collaboration norms.
---

# Coding Skill

## Overview
Apply these language-independent standards whenever you generate or edit code. Prefer simple, readable, and maintainable solutions.

## Core Practices
- Use clear, consistent naming; avoid ambiguous abbreviations.
- Keep code self-explanatory; comment on intent, constraints, and tradeoffs, not restating the code.
- Keep functions/classes small and single-purpose.
- Favor simple, direct solutions; avoid premature abstraction (KISS, YAGNI).
- Reduce duplication when it improves clarity (DRY), but do not over-abstract.
- Keep modules loosely coupled and cohesive; isolate side effects and I/O.
- Follow the project’s existing style guide; let formatters/linters define the baseline.

## Testing & Quality
- Add or update tests that cover the change; select unit, integration, or end-to-end as appropriate.
- Prefer deterministic tests; isolate external dependencies with fakes/mocks/stubs where needed.
- Ensure CI checks pass or note what could not be verified.

## Reliability & Security
- Validate inputs; handle errors explicitly; fail safely with meaningful messages.
- Avoid logging sensitive data; keep secrets out of source control.
- Apply least-privilege and secure defaults; review dependency risks.

## Collaboration & Maintenance
- Make small, focused commits with clear rationale.
- Refactor opportunistically to reduce complexity and technical debt.
- Request or provide reviews; explain non-obvious decisions.

## AI Tools
- Use AI assistance only with human review; verify outputs with tests or trusted checks.

## Output Expectations
- Match existing project conventions first.
- If standards conflict, call it out and choose the safer, clearer option.
