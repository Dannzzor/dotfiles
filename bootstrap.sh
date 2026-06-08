#!/bin/bash

# Bootstrap script for new Mac setup
# Run this once when setting up a new machine:
# curl -L https://raw.githubusercontent.com/YOUR_REPO/dotfiles/master/bootstrap.sh | bash
# OR: ./bootstrap.sh

set -e

echo "🚀 Starting dotfiles bootstrap..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================
# 1. INSTALL HOMEBREW (if needed)
# ============================================
echo "${YELLOW}[1/5] Checking Homebrew...${NC}"

if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH (for Apple Silicon Macs)
  if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "✅ Homebrew already installed"
fi

# ============================================
# 2. INSTALL NVM (if needed)
# ============================================
echo ""
echo "${YELLOW}[2/5] Checking NVM...${NC}"

if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

  # Load nvm for this session
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  echo "Installing Node.js LTS..."
  nvm install --lts
  nvm use --lts
else
  echo "✅ NVM already installed"
fi

# ============================================
# 3. INSTALL BREWFILE PACKAGES
# ============================================
echo ""
echo "${YELLOW}[3/5] Installing Homebrew packages...${NC}"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "Installing from Brewfile..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  echo "✅ Brewfile packages installed"
else
  echo "${RED}❌ Brewfile not found at $DOTFILES_DIR/Brewfile${NC}"
  exit 1
fi

# ============================================
# 4. SET UP DOTFILE SYMLINKS
# ============================================
echo ""
echo "${YELLOW}[4/5] Setting up dotfile symlinks...${NC}"

# Helper function to create symlink with backup
create_symlink() {
  local source="$1"
  local target="$2"
  local target_dir=$(dirname "$target")

  # Create target directory if it doesn't exist
  mkdir -p "$target_dir"

  # Backup existing file/symlink
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "Backing up existing $target to ${target}.bak"
      mv "$target" "${target}.bak"
    else
      rm "$target"
    fi
  fi

  # Create symlink
  ln -s "$source" "$target"
  echo "  ✓ $target"
}

# Backup and replace zshrc (special handling since it's sourced immediately)
if [ -f "$HOME/.zshrc" ]; then
  echo "Backing up existing ~/.zshrc to ~/.zshrc_old"
  mv "$HOME/.zshrc" "$HOME/.zshrc_old"
fi

# Shell configs
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.exports" "$HOME/.exports"
create_symlink "$DOTFILES_DIR/.aliases" "$HOME/.aliases"
create_symlink "$DOTFILES_DIR/.functions" "$HOME/.functions"

# Git configs
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.gitignore" "$HOME/.gitignore"
create_symlink "$DOTFILES_DIR/.git_commit_msg.txt" "$HOME/.git_commit_msg.txt"

# Editor configs
create_symlink "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc"
create_symlink "$DOTFILES_DIR/.npmrc" "$HOME/.npmrc"
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Tmux configs
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.tmux_colors" "$HOME/.tmux_colors"

# Misc configs
create_symlink "$DOTFILES_DIR/.dircolors" "$HOME/.dircolors"
create_symlink "$DOTFILES_DIR/.eslintrc.json" "$HOME/.eslintrc.json"

# AI Agent Configs
create_symlink "$DOTFILES_DIR/ai/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
create_symlink "$DOTFILES_DIR/ai/cursor/.cursorrules" "$HOME/.cursorrules"
create_symlink "$DOTFILES_DIR/ai/copilot/copilot-instructions.md" "$HOME/.config/github-copilot/instructions.md"

# Create empty .extra file for secrets (should NOT be committed)
if [ ! -f "$HOME/.extra" ]; then
  touch "$HOME/.extra"
  echo "  ✓ ~/.extra (created for secrets)"
fi

echo "✅ Dotfile symlinks created"

# ============================================
# 5. OPTIONAL SETUP
# ============================================
echo ""
echo "${YELLOW}[5/5] Optional setup...${NC}"
echo ""
echo "Additional setup options:"
echo "  1) Apply macOS system defaults (mac_setup.sh)"
echo "  2) Set up Neovim config (nvim_settings_install.sh)"
echo "  3) Skip and finish"
echo ""
read -p "Choose option (1-3): " setup_choice

case $setup_choice in
  1)
    echo "Running macOS defaults..."
    bash "$DOTFILES_DIR/mac_setup.sh"
    echo "✅ macOS defaults applied"
    echo ""
    read -p "Continue with Neovim setup? (y/n): " nvim_choice
    if [ "$nvim_choice" = "y" ]; then
      bash "$DOTFILES_DIR/nvim_settings_install.sh"
      echo "✅ Neovim configured"
    fi
    ;;
  2)
    echo "Setting up Neovim..."
    bash "$DOTFILES_DIR/nvim_settings_install.sh"
    echo "✅ Neovim configured"
    ;;
  3)
    echo "Skipping optional setup"
    ;;
  *)
    echo "Invalid choice, skipping"
    ;;
esac

# ============================================
# FINAL STEPS
# ============================================
echo ""
echo "${GREEN}✨ Bootstrap complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open a new terminal to reload shell config"
echo "  2. Set your git identity:"
echo "     git config --global user.name 'Your Name'"
echo "     git config --global user.email 'your.email@example.com'"
echo "  3. Enable git commit template: git config --global commit.template ~/.git_commit_msg.txt"
echo "  4. Review ~/.claude/CLAUDE.md and customize AI agent rules as needed"
echo "  5. Add any machine-specific secrets to ~/.extra"
echo ""
echo "For more info, see:"
echo "  - $DOTFILES_DIR/README.md (if it exists)"
echo "  - $DOTFILES_DIR/ai/README.md (AI agent setup)"
echo ""
