#!/bin/bash

# Skills sync manager: synchronize skills between dotfiles and ~/.claude/skills/
# Usage:
#   ./skills-sync.sh install    # Initial setup (copies skills to ~/.claude/skills/)
#   ./skills-sync.sh sync       # Sync changes from dotfiles to Claude
#   ./skills-sync.sh status     # Check sync status

set -e

DOTFILES_SKILLS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"
CLAUDE_SKILLS="$HOME/.claude/skills"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ============================================
# HELPER FUNCTIONS
# ============================================

sync_skill() {
  local skill_name="$1"
  local src="$DOTFILES_SKILLS/$skill_name/SKILL.md"
  local dst="$CLAUDE_SKILLS/$skill_name/SKILL.md"

  if [ ! -f "$src" ]; then
    echo "${RED}❌ Skill not found: $skill_name${NC}"
    return 1
  fi

  # Create destination directory if it doesn't exist
  mkdir -p "$(dirname "$dst")"

  # Copy the skill file
  cp "$src" "$dst"
  echo "${GREEN}✓${NC} $skill_name"
}

check_skill_sync() {
  local skill_name="$1"
  local src="$DOTFILES_SKILLS/$skill_name/SKILL.md"
  local dst="$CLAUDE_SKILLS/$skill_name/SKILL.md"

  if [ ! -f "$src" ]; then
    echo "${YELLOW}?${NC} $skill_name (source not found)"
    return 1
  fi

  if [ ! -f "$dst" ]; then
    echo "${RED}✗${NC} $skill_name (not in Claude)"
    return 1
  fi

  # Compare mtimes
  src_mtime=$(stat -f%m "$src")
  dst_mtime=$(stat -f%m "$dst")

  if [ "$src_mtime" -gt "$dst_mtime" ]; then
    echo "${YELLOW}⚠${NC} $skill_name (dotfiles version is newer)"
    return 1
  elif [ "$src_mtime" -lt "$dst_mtime" ]; then
    echo "${YELLOW}⚠${NC} $skill_name (Claude version is newer)"
    return 1
  else
    echo "${GREEN}✓${NC} $skill_name (in sync)"
    return 0
  fi
}

# ============================================
# MAIN COMMANDS
# ============================================

case "$1" in
  install)
    echo "Installing skills to $CLAUDE_SKILLS..."
    echo ""

    mkdir -p "$CLAUDE_SKILLS"

    for skill_dir in "$DOTFILES_SKILLS"/*/; do
      skill_name=$(basename "$skill_dir")
      if [ "$skill_name" != "README.md" ]; then
        sync_skill "$skill_name"
      fi
    done

    echo ""
    echo "${GREEN}✅ Skills installed${NC}"
    echo ""
    ;;

  sync)
    echo "Syncing skills from $DOTFILES_SKILLS to $CLAUDE_SKILLS..."
    echo ""

    mkdir -p "$CLAUDE_SKILLS"

    for skill_dir in "$DOTFILES_SKILLS"/*/; do
      skill_name=$(basename "$skill_dir")
      if [ "$skill_name" != "README.md" ]; then
        sync_skill "$skill_name"
      fi
    done

    echo ""
    echo "${GREEN}✅ Skills synced${NC}"
    echo ""
    ;;

  status)
    echo "Skills Sync Status"
    echo "=================="
    echo ""
    echo "Source: $DOTFILES_SKILLS"
    echo "Target: $CLAUDE_SKILLS"
    echo ""

    any_out_of_sync=0

    for skill_dir in "$DOTFILES_SKILLS"/*/; do
      skill_name=$(basename "$skill_dir")
      if [ "$skill_name" != "README.md" ]; then
        if ! check_skill_sync "$skill_name"; then
          any_out_of_sync=1
        fi
      fi
    done

    echo ""
    if [ $any_out_of_sync -eq 0 ]; then
      echo "${GREEN}✅ All skills in sync${NC}"
    else
      echo "${YELLOW}⚠️  Some skills need syncing${NC}"
      echo "Run: ~/repos/dotfiles/ai/skills-sync.sh sync"
    fi
    echo ""
    ;;

  *)
    echo "Skills Sync Manager"
    echo "==================="
    echo ""
    echo "Usage: $0 {install|sync|status}"
    echo ""
    echo "Commands:"
    echo "  install    Initial setup - copy skills to ~/.claude/skills/"
    echo "  sync       Sync changes from dotfiles to Claude"
    echo "  status     Check if skills are in sync"
    echo ""
    echo "Examples:"
    echo "  $0 install"
    echo "  $0 sync"
    echo "  $0 status"
    echo ""
    ;;
esac
