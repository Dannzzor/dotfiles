#!/bin/bash

# Install dotfiles symlinks for existing setup
# Use this if you already have Homebrew, nvm, and packages installed
# For fresh machine setup, use: ./bootstrap.sh

set -e

echo "Installing dotfile symlinks..."
echo ""

# backup current zshrc
if [ -f ~/.zshrc ]; then
  echo "Backing up existing ~/.zshrc to ~/.zshrc_old"
  mv ~/.zshrc ~/.zshrc_old
fi

# Shell configs
ln -is ~/repos/dotfiles/.zshrc ~/.zshrc
ln -is ~/repos/dotfiles/.exports ~/.exports
ln -is ~/repos/dotfiles/.aliases ~/.aliases
ln -is ~/repos/dotfiles/.functions ~/.functions

# Git configs
ln -is ~/repos/dotfiles/.gitconfig ~/.gitconfig
ln -is ~/repos/dotfiles/.gitignore ~/.gitignore
ln -is ~/repos/dotfiles/.git_commit_msg.txt ~/.git_commit_msg.txt

# Editor configs
ln -is ~/repos/dotfiles/.inputrc ~/.inputrc
ln -is ~/repos/dotfiles/.npmrc ~/.npmrc
ln -is ~/repos/dotfiles/.vimrc ~/.vimrc

# Tmux configs
ln -is ~/repos/dotfiles/.tmux.conf ~/.tmux.conf
ln -is ~/repos/dotfiles/.tmux_colors ~/.tmux_colors

# Misc configs
ln -is ~/repos/dotfiles/.dircolors ~/.dircolors
ln -is ~/repos/dotfiles/.eslintrc.json ~/.eslintrc.json

# AI Agent Configs
# These centralize rules and conventions for Claude Code, Cursor, and GitHub Copilot
# See ~/repos/dotfiles/ai/STANDARDS.md for the source of truth

mkdir -p ~/.config/github-copilot

ln -is ~/repos/dotfiles/ai/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -is ~/repos/dotfiles/ai/cursor/.cursorrules ~/.cursorrules
ln -is ~/repos/dotfiles/ai/copilot/copilot-instructions.md ~/.config/github-copilot/instructions.md

# create the "extra" file that contains secrets that SHOULD NOT BE COMMITTED
touch ~/.extra

echo ""
echo "✅ Dotfile symlinks created"
echo ""
echo "Next steps:"
echo "  1. Open a new terminal to reload shell config"
echo "  2. Update git config template: git config --global commit.template ~/.git_commit_msg.txt"
