---
name: context7-library-refs
description: Use when a request needs external library/framework API usage, code examples, or implementation details (e.g., "how to use X SDK", "show me Y API call", "what's the correct config for Z"). Always retrieve the library docs via Context7 (resolve-library-id then query-docs) before answering.
---

# Context7 Library Refs

## Overview

Ensure all external library or framework references are grounded in Context7 docs. This prevents stale or hallucinated API usage and keeps answers tied to official documentation.

## Workflow

1. **Decide if Context7 is required**
   - Trigger if the user asks for library/framework usage, APIs, configuration, or code snippets.
   - If unsure, ask a brief clarification or proceed with Context7.

2. **Resolve the library id**
   - Call `mcp__context7__resolve-library-id` with the library/package name.
   - If the user already provides a Context7 ID (e.g., `/org/project`), skip this step.
   - If multiple matches, pick the most relevant by name + description; ask if ambiguous.

3. **Query docs**
   - Call `mcp__context7__query-docs` with a specific, scoped question.
   - Keep to ≤3 total Context7 calls per user request.

4. **Answer with grounded output**
   - Use only information supported by Context7 docs.
   - Provide concise examples; avoid extra boilerplate.
   - If docs do not cover the requested detail, say so and suggest alternatives or ask a follow‑up.

5. **Failure handling**
   - If no suitable library is found or docs are missing, state that clearly and ask for clarification.

## Notes

- Do not use general memory for APIs when Context7 is available.
- If the user asks for “latest” APIs or breaking changes, always use Context7.
