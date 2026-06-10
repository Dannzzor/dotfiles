#!/bin/bash

# Set up Neovim configuration from dotfiles
# Usage: ./nvim_settings_install.sh

set -e

echo "Setting up Neovim configuration..."
echo ""

# Create nvim directories
mkdir -p ~/.config/nvim/lua/custom/plugins
mkdir -p ~/.config/nvim/lua/kickstart/plugins

# Symlink nvim configs
ln -is ~/repos/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -is ~/repos/dotfiles/nvim/kickstart_nvim/init.lua ~/.config/nvim/lua/custom/plugins/init.lua
ln -is ~/repos/dotfiles/nvim/kickstart_nvim/autoformat.lua ~/.config/nvim/lua/kickstart/plugins/autoformat.lua
ln -is ~/repos/dotfiles/nvim/kickstart_nvim/debug.lua ~/.config/nvim/lua/kickstart/plugins/debug.lua

echo "✅ Neovim configuration complete"
echo ""
echo "Start nvim with: nvim"
