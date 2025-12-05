#!/bin/bash

# you may need to make this executable with:
# chmod u+x nvim_settings_install.sh

# then to run, use:
# ./nvim_settings_install.sh

mkdir -p ~/.config/nvim
ln -i ~/repos/dotfiles/nvim/init.lua ~/.config/nvim/init.lua

mkdir -p ~/.config/nvim/lua/custom/plugins
ln -i ~/repos/dotfiles/nvim/kickstart_nvim/init.lua ~/.config/nvim/lua/custom/plugins/init.lua

mkdir -p ~/.config/nvim/lua/kickstart/plugins
ln -i ~/repos/dotfiles/nvim/kickstart_nvim/autoformat.lua ~/.config/nvim/lua/kickstart/plugins/autoformat.lua
ln -i ~/repos/dotfiles/nvim/kickstart_nvim/debug.lua ~/.config/nvim/lua/kickstart/plugins/debug.lua
