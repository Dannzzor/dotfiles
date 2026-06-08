#!/bin/bash

# Sync check script: compares mtimes of tool configs relative to STANDARDS.md
# Run this after updating STANDARDS.md to see which tool configs need refreshing

DOTFILES_AI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STANDARDS="$DOTFILES_AI/STANDARDS.md"

if [[ ! -f "$STANDARDS" ]]; then
  echo "Error: STANDARDS.md not found at $STANDARDS"
  exit 1
fi

STANDARDS_MTIME=$(stat -f%m "$STANDARDS")

echo "Sync Check Report"
echo "================="
echo "Standards file: $STANDARDS"
echo ""

# Check each tool config
configs=(
  "claude/CLAUDE.md:~/.claude/CLAUDE.md"
  "cursor/.cursorrules:~/.cursorrules"
  "copilot/copilot-instructions.md:~/.config/github-copilot/instructions.md"
)

for config_pair in "${configs[@]}"; do
  local_path="${config_pair%:*}"
  target_path="${config_pair#*:}"
  target_expanded=$(eval echo "$target_path")

  local_file="$DOTFILES_AI/$local_path"

  if [[ ! -f "$local_file" ]]; then
    echo "❌ Missing: $local_path"
    continue
  fi

  local_mtime=$(stat -f%m "$local_file")

  if [[ $local_mtime -lt $STANDARDS_MTIME ]]; then
    echo "⚠️  Stale: $local_path (last updated before STANDARDS.md)"
    echo "   Target: $target_expanded"
  else
    echo "✅ Current: $local_path"
  fi
done

echo ""
echo "Tip: Update tool configs when you see ⚠️ stale flags"
