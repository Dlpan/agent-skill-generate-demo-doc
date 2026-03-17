# generate-demo-doc

Portable agent skill package for turning a GitHub PR or Jira ticket into a demo-ready document with a business-first narrative and optional Feishu publishing.

This repository is meant to be both:

- a usable skill package for `generate-demo-doc`
- a reference template for building cross-agent skill repositories

## Overview

`generate-demo-doc` helps an agent transform engineering artifacts into a demo script a product, delivery, or go-to-market audience can actually use. Instead of producing a changelog or implementation summary, it builds a presenter-friendly document with user story, problem framing, before/after, talking points, and a live-demo path.

The package is intentionally structured so the core skill stays portable while each agent tool gets only a thin adapter.

## Features

- Accepts a GitHub PR URL, PR number, Jira URL, or Jira key.
- Prioritizes Jira for product intent, PR for shipped scope, and repo docs for terminology.
- Produces a consistent output structure based on a shared template.
- Supports optional Feishu publishing with title-search verification.
- Keeps temporary markdown in `/tmp` and cleans it up only after confirmed publish.
- Ships separate adapters for Codex, Claude Code, and Cursor.

## Why This Repo Shape

A reusable agent skill repository should separate the capability itself from the runtime that hosts it.

- `skill.yaml` describes the portable contract.
- `PROMPT.md` contains the shared behavior.
- `references/` stores reusable templates and assets.
- `adapters/` maps the shared capability into specific tools.
- runtime-specific compatibility files stay thin and disposable.

If all behavior lives inside one vendor-specific file, the project is a tool prompt. If the behavior lives in a shared contract with small adapters, it is much closer to a reusable skill package.

## Repository Layout

```text
.
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
├── README.md
├── examples
│   ├── sample-output.md
│   └── sample-requests.md
└── generate-demo-doc
    ├── PROMPT.md
    ├── SKILL.md
    ├── adapters
    │   ├── claude
    │   │   └── CLAUDE.md
    │   └── cursor
    │       └── generate-demo-doc.mdc
    ├── agents
    │   └── openai.yaml
    ├── references
    │   └── demo-template.md
    └── skill.yaml
```

## Portable Contract

The portable surface of this skill is defined by [generate-demo-doc/skill.yaml](generate-demo-doc/skill.yaml).

Core contract:

- Inputs: GitHub PR URL, PR number, Jira URL, Jira key.
- Optional context: local repository docs.
- Primary output: markdown demo document.
- Optional output: Feishu document.
- Shared prompt: [generate-demo-doc/PROMPT.md](generate-demo-doc/PROMPT.md).
- Shared template: [generate-demo-doc/references/demo-template.md](generate-demo-doc/references/demo-template.md).

## Supported Runtimes

This repository currently includes adapters for:

- Codex via [generate-demo-doc/SKILL.md](generate-demo-doc/SKILL.md)
- Claude Code via [generate-demo-doc/adapters/claude/CLAUDE.md](generate-demo-doc/adapters/claude/CLAUDE.md)
- Cursor via [generate-demo-doc/adapters/cursor/generate-demo-doc.mdc](generate-demo-doc/adapters/cursor/generate-demo-doc.mdc)

## Prerequisites

Before using the skill in any runtime, make sure you have:

- GitHub CLI installed.
- GitHub CLI authenticated with `gh auth login`.
- Jira access configured in the current runtime.
- Feishu document creation and search access configured in the current runtime if you want publishing.
- Local access to the target code repository if you want repo-doc enrichment.

Without Jira or Feishu access, the skill can still partially work, but the result will be less complete.

## Quick Start

Choose the path that matches your runtime:

- Codex: run `./scripts/install-codex-skill.sh`, then restart Codex.
- Claude Code: point your task or project instruction to `generate-demo-doc/adapters/claude/CLAUDE.md`.
- Cursor: load `generate-demo-doc/adapters/cursor/generate-demo-doc.mdc` as a project rule.

If you only want to inspect or reuse the prompt, start with [generate-demo-doc/PROMPT.md](generate-demo-doc/PROMPT.md) and [generate-demo-doc/references/demo-template.md](generate-demo-doc/references/demo-template.md) without installing anything.

## Installation

### Codex

Fastest local install:

```bash
./scripts/install-codex-skill.sh
```

Alternative install options:

- Use your preferred Codex skill installer.
- Create the symlink manually.

Install from GitHub with a Codex skill installer:

```bash
install-skill-from-github.py --repo <owner>/codex-skill-generate-demo-doc --path generate-demo-doc
```

Or install manually:

```bash
mkdir -p ~/.codex/skills
ln -s /path/to/codex-skill-generate-demo-doc/generate-demo-doc ~/.codex/skills/generate-demo-doc
```

If `generate-demo-doc` already exists under `~/.codex/skills`, remove or replace it first.

### Claude Code

No installation step is usually required. Keep this repository in the workspace and load `generate-demo-doc/adapters/claude/CLAUDE.md` as the task or project instruction so it can reference the shared prompt and template.

### Cursor

No package install is usually required. Copy or symlink `generate-demo-doc/adapters/cursor/generate-demo-doc.mdc` into the rule location used by your Cursor project, and keep the repository contents available next to it.

## Usage

Typical requests:

```text
用这个 PR 生成 demo 文档：https://github.com/acme/product/pull/1234
```

```text
基于这个 Jira 生成 demo 文档：APP-2048
```

```text
使用 $generate-demo-doc，把这个需求整理成方便 team demo 的飞书文档：APP-2048
```

More examples live in [examples/sample-requests.md](examples/sample-requests.md).

## Output Behavior

The skill always tries to produce a structured demo document with:

- one-line summary
- user story
- problem statement
- solution and outcome
- scenarios
- before and after framing
- talking points
- 30-second and 90-second demo scripts
- recommended live-demo path
- one backup technical sentence

An abbreviated sample is available in [examples/sample-output.md](examples/sample-output.md).

## Execution Model

The shared prompt follows this source priority:

1. Jira for business intent, user story, and acceptance criteria.
2. PR for actual shipped scope and user-visible surfaces.
3. Local repo docs for product wording and supporting context.

If Feishu publishing is enabled in the runtime, the skill writes a temporary markdown file under `/tmp`, attempts to import it, verifies existence by title search, and removes the temp file only after successful confirmation.

## Use This Repo As a Template

If you want to create another portable skill repository, reuse this layout and change only the skill-specific pieces:

1. duplicate `generate-demo-doc/` into a new skill directory
2. rewrite `skill.yaml` for the new contract
3. replace `PROMPT.md` with the new shared behavior
4. replace files under `references/`
5. keep adapters thin and point them back to the shared prompt
6. update `README.md`, `examples/`, and `CHANGELOG.md`

## Development

When evolving this repository:

- put business behavior in `PROMPT.md`
- keep adapters as wrappers, not sources of truth
- update examples when the prompt contract changes
- document user-visible changes in `CHANGELOG.md`

Contribution guidance lives in [CONTRIBUTING.md](CONTRIBUTING.md).

## Troubleshooting

### GitHub auth issues

Check:

```bash
gh auth status
```

If needed:

```bash
gh auth login -h github.com
```

### Jira content cannot be fetched

Check that Jira access is configured in the current runtime and that the issue key or URL is valid.

### Feishu publishing cannot be confirmed

Check that both document import and title search are available in the current runtime. If confirmation is ambiguous or missing, keep the generated markdown for manual recovery.

### Local repo docs are missing

This is not fatal. The skill will continue with Jira and PR context only.

## Versioning

This repository uses SemVer for the portable skill-package surface. Public contract changes should be reflected in `generate-demo-doc/skill.yaml`, examples, and `CHANGELOG.md`.

## License

This repository is released under the MIT License. See [LICENSE](LICENSE).
