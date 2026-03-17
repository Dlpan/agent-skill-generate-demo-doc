---
name: generate-demo-doc
description: Generate a demo-ready Feishu document from a GitHub PR or Jira ticket. Use when the user wants a concise internal demo稿, presentation notes, or business-facing summary from a PR URL, PR number, Jira URL, or Jira key, with emphasis on user story, outcome, before/after, demo script, and minimal technical detail.
---

# Generate Demo Doc

Use this skill to turn a PR or Jira ticket into a business-first demo document for internal team demos.

Prefer Chinese narrative with natural English product terms. Optimize for demo audience, not implementation review. Keep the original Jira user story in English when it exists, then add a Chinese restatement.

## Workflow

### 1. Normalize the input

Accept any of these forms:

- GitHub PR URL
- PR number
- Jira URL
- Jira key

If the input is a PR:

- Fetch PR metadata first with `gh pr view`.
- Extract the Jira key from the PR title first.
- If the title does not contain a Jira key, check PR body, branch name, and commit titles.

If the input is a Jira ticket:

- Fetch Jira first.
- If a related PR is obvious from Jira content or local repo evidence, use it as supporting context.

### 2. Build source context in this priority order

Use sources in this order:

1. Jira for business intent, user story, acceptance criteria, scope, and pain points.
2. PR for implemented scope, user-visible surfaces, and changed files.
3. Local repo docs for existing terminology, product framing, and feature notes.

When searching the repo:

- Search by Jira key first.
- Then search by feature title keywords from Jira summary and PR title.
- Prefer local Markdown files in `docs/`.

If repo docs do not exist, continue with Jira + PR only.

If Jira cannot be found from a PR, continue with PR-only context and explicitly state that Jira context was unavailable.

## Required output structure

Follow the template in `references/demo-template.md`.

Always include these sections:

- One-line summary
- User Story
- Problem being solved
- Solution / Outcome
- Applicable scenarios
- Before & After
- Demo talking points
- 30-second script
- 90-second script
- Recommended live demo path
- One backup technical sentence

## Content rules

- Write for internal team demo use.
- Keep the tone business-facing and presentation-friendly.
- Prefer workflow change and business value over code details.
- Preserve useful English product terms such as `appointment drawer`, `date picker`, `payment status`, `calendar card`.
- Avoid turning the document into a changelog or code review.
- Use technical detail only as one short backup sentence near the end.

## Title rules

Use this title format when a Jira key exists:

`<JIRA_KEY> Demo 稿：<business-facing feature title>`

If no Jira key can be resolved, use:

`PR-<number> Demo 稿：<business-facing feature title>`

Prefer a business-facing title over the raw PR title. Rewrite technical wording into user-visible language when possible.

## Feishu creation and verification

Write the transient Markdown to `/tmp`, not the repo.

Then:

1. Create the Feishu doc with `mcp__feishu__docx_builtin_import`.
2. Verify existence by title search with `mcp__feishu__docx_builtin_search`.
3. If import reports an error but title search finds exactly one matching doc with the expected title, treat the creation as successful.
4. If title search returns multiple ambiguous matches, keep the temp Markdown and report the ambiguity.
5. If the doc cannot be confirmed, keep the temp Markdown and report its path.

Delete the temporary Markdown only after Feishu existence is confirmed.

## Cleanup rules

- Temporary Markdown must live under `/tmp`.
- Do not create repo-tracked temp docs as part of normal usage.
- After confirmed Feishu creation, remove the temp Markdown.
- If confirmation fails, keep the temp Markdown for manual recovery and tell the user where it is.

## Suggested execution pattern

For PR input:

1. `gh pr view` for title, body, merge commit, changed files, branch names.
2. Jira fetch using the extracted key.
3. Repo search for related docs.
4. Draft the demo document from the combined context.
5. Save draft to `/tmp/<title-slug>.md`.
6. Import to Feishu.
7. Search Feishu by exact title to confirm existence.
8. Delete the temp file only after confirmation.

For Jira input:

1. Fetch Jira first.
2. Search repo docs by key and summary keywords.
3. If needed, search for a related PR or merge commit as supporting context.
4. Draft the demo document.
5. Save, import, verify, and clean up using the same `/tmp` flow.

## Examples

These user requests should trigger this skill:

- `基于这个 PR 生成 demo 文档：<GitHub PR URL>`
- `帮我把这个 PR 整成 demo 稿：<PR_NUMBER>`
- `基于这个 Jira 生成 demo 文档：<JIRA_KEY>`
- `把这个需求总结成方便我 team demo 的飞书文档`

## Notes

- Treat Feishu title search as the confirmation step when import behavior is unreliable.
- If Jira and PR disagree, use Jira for product intent and PR for actual shipped scope.
- Keep the final user-facing response short: doc title, whether Feishu creation was confirmed, and whether the temp file was deleted.
