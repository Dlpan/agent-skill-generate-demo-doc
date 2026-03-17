# codex-skill-generate-demo-doc

Public single-skill repository for `generate-demo-doc`, a Codex skill that turns a GitHub PR or Jira ticket into a demo-ready Feishu document.

The skill is designed for internal team demos where the presenter needs a business-first summary instead of a technical implementation review. It pulls context from GitHub, Jira, local repo docs, and Feishu MCP, then generates a structured demo稿 with user story, outcome, before/after, demo script, and live demo path.

## What This Skill Does

Use `generate-demo-doc` when you want Codex to:

- read a GitHub PR URL or PR number,
- read a Jira URL or Jira key,
- combine Jira intent, PR shipped scope, and local repo docs,
- write a business-facing demo document,
- create the final document in Feishu,
- verify Feishu creation by title search when import returns a tool error,
- delete the temporary Markdown only after Feishu existence is confirmed.

## When To Use It

This skill is a good fit when you want to say things like:

- `用这个 PR 生成 demo 文档：<GitHub PR URL>`
- `基于这个 Jira 生成 demo 文档：<JIRA_KEY>`
- `帮我把这个需求整理成 team demo 稿`

This skill is not intended for:

- code review writeups,
- release notes,
- external customer-facing announcements,
- full technical design docs.

## Requirements

Before using this skill, make sure your environment is ready:

- Codex with skills support enabled.
- GitHub CLI installed.
- GitHub CLI authenticated with a valid token via `gh auth login`.
- Atlassian / Jira MCP configured and authorized.
- Feishu MCP configured and authorized for both doc creation and doc search.
- Local access to the target code repository if you want the skill to include repo docs in the summary.

Important:

- If `gh auth status` shows an invalid token, re-authenticate before trying to use or publish this skill.
- The skill depends on Jira and Feishu MCP access. Without them, it can still partially work, but the result will be less complete.

## Install

### Option 1: Install from GitHub with the skill installer

If you already have the Codex skill installer helpers available, install the skill from this repo path:

```bash
install-skill-from-github.py --repo <owner>/codex-skill-generate-demo-doc --path generate-demo-doc
```

Example:

```bash
install-skill-from-github.py --repo your-github-username/codex-skill-generate-demo-doc --path generate-demo-doc
```

After installation, restart Codex so the new skill is picked up.

### Option 2: Manual install

Clone the repo:

```bash
git clone https://github.com/<owner>/codex-skill-generate-demo-doc.git
```

Link the skill into your Codex skills directory:

```bash
mkdir -p ~/.codex/skills
ln -s /path/to/codex-skill-generate-demo-doc/generate-demo-doc ~/.codex/skills/generate-demo-doc
```

Then restart Codex.

## Usage

After installation, you can call the skill explicitly:

```text
使用 $generate-demo-doc，用这个 PR 生成 demo 文档：<GitHub PR URL>
```

Or more casually:

```text
用这个 PR 生成 demo 文档：<GitHub PR URL>
```

You can also use Jira directly:

```text
基于这个 Jira 生成 demo 文档：<JIRA_KEY>
```

## How It Works

The skill uses this priority order when building context:

1. Jira for business intent, user story, acceptance criteria, and scope.
2. PR for actual shipped scope and user-visible surfaces.
3. Local repo docs for product language and supporting context.

It writes a transient Markdown draft to `/tmp`, creates the Feishu doc, verifies doc existence via Feishu title search, and only then deletes the temp file.

This is important because some Feishu MCP environments may report an import error even when the document was actually created successfully.

## Notes About Feishu Import Errors

In some environments, `docx_builtin_import` may fail with a transport or content-type error while the document is still created successfully in Feishu.

This skill treats Feishu title search as the source of truth:

- if title search finds exactly one matching doc, creation is treated as successful;
- if confirmation is ambiguous or missing, the temp Markdown is kept for manual recovery.

## Troubleshooting

### GitHub auth fails

Check:

```bash
gh auth status
```

If the token is invalid, run:

```bash
gh auth login -h github.com
```

### Jira content cannot be fetched

Check that:

- Atlassian MCP is configured,
- your account has permission to the Jira project,
- the Jira key or URL is correct.

### Feishu doc creation fails

Check that:

- Feishu MCP is configured,
- the account has permission to create docs,
- doc search is also available so the skill can verify existence.

If import fails but the doc exists, the skill should still recover by title search.

### Local repo docs are missing

This is not fatal. The skill will continue using Jira + PR only and note the missing repo-doc context when needed.

## Repository Layout

```text
.
├── LICENSE
├── README.md
└── generate-demo-doc
    ├── SKILL.md
    ├── agents
    │   └── openai.yaml
    └── references
        └── demo-template.md
```
