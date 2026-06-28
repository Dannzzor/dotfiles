#!/bin/bash

# Sync global Claude Code config from this dotfiles repo into ~/.claude via symlinks.
#
# Symlinks (single source of truth = this repo, so edits sync across machines on push/pull):
#   ~/.claude/CLAUDE.md        -> ai/claude/CLAUDE.md      (global working rules)
#   ~/.claude/commands         -> ai/claude/commands       (custom slash commands)
#   ~/.claude/skills/<name>    -> ai/skills/<name>         (custom skills, per-skill)
#
# Deliberately NOT synced: ~/.claude/projects (project history + memory — keep work
# and personal separate), settings.json, plugins, and marketplace-installed skills
# (find-skills, skill-creator — those reinstall via the plugin marketplace).
#
# Idempotent: safe to re-run. Existing real files are backed up to *.bak;
# existing symlinks are replaced.
#
# Usage: ./ai/sync-claude.sh

set -e

DOTFILES_AI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

link() {
  local src="$1" target="$2"
  mkdir -p "$(dirname "$target")"
  if [ -L "$target" ]; then
    rm "$target"
  elif [ -e "$target" ]; then
    echo "  backing up existing $target -> ${target}.bak"
    rm -rf "${target}.bak"
    mv "$target" "${target}.bak"
  fi
  ln -s "$src" "$target"
  printf "  ${GREEN}✓${NC} %s -> %s\n" "$target" "$src"
}

printf "${YELLOW}Syncing Claude config from %s${NC}\n" "$DOTFILES_AI"

# Global rules
link "$DOTFILES_AI/claude/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Custom slash commands (whole directory)
link "$DOTFILES_AI/claude/commands" "$CLAUDE_DIR/commands"

# Custom skills (per-skill, leaving marketplace-installed skills untouched)
for skill_dir in "$DOTFILES_AI"/skills/*/; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"
  link "${skill_dir%/}" "$CLAUDE_DIR/skills/$name"
done

printf "${GREEN}✅ Claude config synced.${NC} Restart Claude Code sessions to pick up changes.\n"
