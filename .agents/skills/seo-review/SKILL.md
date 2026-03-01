---
name: seo-review
description: Perform focused SEO audits and optimization recommendations for content pages (docs, blog posts, guides, tutorials, landing pages, product/feature pages). Use when asked for SEO review, keyword targeting, title/meta improvements, featured snippet optimization, internal linking, or technical SEO checks.
---

# Skill: SEO Review (Generic)

## Quick Start

- Collect the page content (draft or URL), target audience, and primary goal.
- Identify page type (concept, how-to, product/feature, landing, comparison, FAQ).
- Build a keyword cluster and search intent summary.
- Audit on-page, content structure, snippets, internal links, and technical SEO.
- Provide a scored report with prioritized fixes and suggested copy edits.

## Required Inputs

- Page content or URL (preferred: markdown/MDX source).
- Target audience and intent (informational, commercial, transactional).
- Primary keyword or topic (if unknown, propose one).
- Page type and constraints (CMS limits, brand voice, legal requirements).
- Optional: analytics (rankings, traffic, CTR, conversions) and competitors.

If inputs are missing, ask only the minimum questions needed to proceed.

## Workflow

1. Clarify goal and intent
   - Define the primary job-to-be-done and expected query intent.
   - Confirm target keyword and supporting queries.

2. Build keyword cluster
   - Select a primary keyword plus 3-8 secondary variants.
   - Use the templates in `references/keyword-cluster-templates.md`.
   - Ensure the cluster matches the page intent and audience vocabulary.

3. Run the on-page audit
   - Check title, meta description, headings, URL slug, and intro.
   - Verify keyword placement and natural readability.
   - Audit media (alt text), code examples (if relevant), and UX scannability.

4. Optimize for featured snippets and SERP features
   - Add a 40-60 word definition for "What is" queries when relevant.
   - Use steps/lists for "How to" queries and tables for comparisons.
   - Add FAQ/accordion patterns when appropriate.

5. Review internal linking and information architecture
   - Add 3-5 related internal links with descriptive anchors.
   - Ensure prerequisite links and a related section exist where useful.

6. Check technical SEO and trust signals
   - Single H1, indexable page, canonical, clean slug, no broken links.
   - Mobile readability, performance hints, and structured data if applicable.
   - Add author/date/source citations when accuracy matters.

7. Produce report and fixes
   - Use the report template in `references/seo-audit-report-template.md`.
   - Provide a score, top issues, and concrete rewrites.

## Output Requirements

- Provide a short summary (2-4 bullets).
- Provide a scored checklist and prioritized fixes.
- Include revised title and meta description suggestions when needed.
- If asked, provide edited copy blocks or diffs.

## References

- `references/keyword-cluster-templates.md`
- `references/seo-audit-checklists.md`
- `references/seo-audit-report-template.md`
