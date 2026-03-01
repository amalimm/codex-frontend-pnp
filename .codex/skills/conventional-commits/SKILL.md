---
name: conventional-commits
description: Create detailed, high-quality git commit messages that follow the Conventional Commits v1.0.0 spec, including structured bodies, issue/epic references, and optional release notes. Use when asked to craft a commit message, run git commit, or enforce type/scope/breaking-change conventions (especially when more context or release-note annotations are needed).
---

# Conventional Commits (Detailed)

Follow the Conventional Commits v1.0.0 format to propose and execute commits, with a fuller body,
issue/epic references, and optional release note annotations when a repo expects them.

## Workflow

1. Inspect changes with `git status` and `git diff` (or `git diff --staged`) to understand scope.
2. Ensure workspace hygiene: before finalizing, run `git status -sb` and remove any untracked or leftover artifacts that are not part of the task. If ownership is unclear, ask the user before deleting.
3. If changes span multiple concerns, split into multiple commits.
4. Identify the primary area/package and map it to `scope` when helpful.
5. Collect inputs:
   - Issue/epic number(s), if any
   - Whether release notes are required and which category fits
   - Any breaking changes and their user impact
5. Choose the `type` and optional `scope`.
6. Write the summary line (imperative, <= 72 chars, no period).
7. Write a detailed body: before/after, why, impact, alternatives, side effects.
8. Add footers: issue/epic references, breaking-change footer if needed.
9. Add a release note annotation when required (or `Release note: None`).

## Format

```
type(scope)!: summary

body (optional)

footer (optional)
```

Rules:
- `type` is required; `scope` is optional.
- Use `!` to indicate a breaking change.
- Keep summary <= 72 chars and in imperative mood.
- Use `BREAKING CHANGE:` footer when breaking but `!` is omitted.
- Separate subject and body with a blank line.
- Wrap body lines at ~72-100 chars.

## Types

Common types:
- `feat`: new feature
- `fix`: bug fix
- `docs`: documentation
- `style`: formatting, whitespace, lint-only
- `refactor`: code change without behavior change
- `perf`: performance improvement
- `test`: add or update tests
- `build`: build system or dependencies
- `ci`: CI configuration
- `chore`: maintenance tasks
- `revert`: revert a previous commit

## Body guidance

Explain:
- What changed (before/after)
- Why the change was needed
- How it impacts users or downstream code
- Alternatives considered (if relevant)
- Side effects or risks

## Footers

Use footers for:
- `BREAKING CHANGE: ...`
- Issue references like `Refs: #123`, `Closes: #123`, or `Resolves: #123`
- Epic references like `Epic: CRDB-357` (or repo equivalent)

## Release notes (optional but often required)

If the repository expects release notes, always include an annotation even when empty:

```
Release note (category): Description of user-facing change.
```

Use `Release note: None` for internal-only changes.

Valid categories (use only if the repo defines them; otherwise pick a sensible generic label):
- backward-incompatible change
- enterprise change
- ops change
- cli change
- sql change
- ui change
- security update
- performance improvement
- cluster virtualization
- bug fix
- general change
- build change

Release note best practices:
- Describe what changed and why it matters to users.
- Use past or present tense ("Fixed", "Now supports").
- For bug fixes, mention cause, symptoms, and affected versions if known.

## Execution

- If the user wants a one-liner, use `git commit -m "<message>"`.
- If a body/footers are needed, use multiple `-m` flags.

## Examples

Standard:
```
feat(ui): add theme toggle

Add a header toggle to switch themes without reloading.
This improves accessibility for low-vision users.
```

With issue and release note:
```
fix(api): handle empty cache entries

Return a 204 when the cache key exists but is empty. Previously this
returned 500 and broke client retries.

Resolves: #123
Release note (bug fix): Fixed an error where empty cache keys returned 500
instead of 204, allowing clients to retry safely.
```

Breaking change:
```
refactor(auth)!: remove legacy token format

Stop accepting v1 tokens that lack issuer claims. Migrate clients to v2.

BREAKING CHANGE: v1 tokens are no longer accepted; clients must upgrade.
```
