# generate-demo-doc for Claude Code

Use the shared instructions in `../../PROMPT.md` as the source of truth.

When the user asks to create a demo document from a GitHub PR or Jira ticket:

1. Accept a PR URL, PR number, Jira URL, or Jira key.
2. Follow the workflow and output structure defined in `../../PROMPT.md`.
3. Use `../../references/demo-template.md` as the response template.
4. Prefer Jira for business intent, PR for shipped scope, and local repo docs for product wording.
5. If Feishu tooling is available in the current environment, create and verify the document; otherwise return the markdown draft only.

Platform notes:

- Claude Code does not use Codex `SKILL.md` discovery, so this file acts as the adapter prompt.
- Replace any Codex-specific tool names with the equivalent tools available in the current Claude Code environment.
- Keep temp markdown under `/tmp` if a file needs to be written before publishing.
