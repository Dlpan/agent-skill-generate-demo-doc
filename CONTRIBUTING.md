# Contributing

Thanks for contributing.

This repository is intentionally structured as a portable skill package rather than a single vendor-specific prompt. The shared capability should live once, and each agent platform should only add the thinnest adapter needed for discovery or runtime attachment.

## Repository Model

Use these ownership rules when editing the repo:

- `generate-demo-doc/skill.yaml`: portable metadata for the skill package.
- `generate-demo-doc/PROMPT.md`: shared behavior and workflow instructions.
- `generate-demo-doc/references/`: reusable templates or assets.
- `generate-demo-doc/adapters/`: platform-specific wrappers.
- `generate-demo-doc/SKILL.md`: Codex compatibility adapter.

If a change affects the business behavior of the skill, update `PROMPT.md` first and then align adapters only where necessary.

## Local Checklist

Before opening a PR:

1. Keep the shared behavior in `PROMPT.md`, not duplicated across adapters.
2. Make sure all adapter files point to the same shared prompt and references.
3. Keep temporary-file guidance under `/tmp` and out of the repository.
4. Update `README.md` if the public install or usage story changes.
5. Update `CHANGELOG.md` for user-visible changes.

## Adding a New Adapter

When adding support for another tool:

1. Create a new file under `generate-demo-doc/adapters/<tool>/`.
2. Keep it thin: adapter files should explain how that tool loads or injects the shared prompt.
3. Reference `PROMPT.md` and `references/demo-template.md` instead of copying their contents.
4. Add the adapter entry to `generate-demo-doc/skill.yaml`.
5. Document installation and usage in `README.md`.

## Changing the Prompt Contract

Treat these items as the public contract of the skill:

- accepted input forms,
- source priority order,
- required output sections,
- publishing and verification behavior,
- temp-file cleanup behavior.

If you change that contract, update:

1. `generate-demo-doc/PROMPT.md`
2. `generate-demo-doc/skill.yaml`
3. examples under `examples/`
4. `README.md`
5. `CHANGELOG.md`

## Release Notes

Use SemVer for the portable package surface:

- patch: wording cleanup, docs-only fixes, non-breaking adapter updates,
- minor: additive prompt capabilities, new adapters, new optional metadata,
- major: breaking changes to inputs, output structure, or repository contract.

## Pull Request Style

- Keep changes focused.
- Prefer plain Markdown and ASCII unless the file already contains non-ASCII content.
- Preserve portability: do not move business logic into a single vendor adapter.
