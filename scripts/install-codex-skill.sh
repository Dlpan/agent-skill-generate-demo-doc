#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_SOURCE="$ROOT_DIR/generate-demo-doc"
SKILLS_DIR="${HOME}/.codex/skills"
TARGET_LINK="${SKILLS_DIR}/generate-demo-doc"

mkdir -p "$SKILLS_DIR"

if [ -L "$TARGET_LINK" ] || [ -e "$TARGET_LINK" ]; then
  rm -rf "$TARGET_LINK"
fi

ln -s "$SKILL_SOURCE" "$TARGET_LINK"

echo "Installed Codex skill:"
echo "  source: $SKILL_SOURCE"
echo "  target: $TARGET_LINK"
echo
echo "Restart Codex if it is already running."
