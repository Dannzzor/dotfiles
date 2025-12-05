#!/bin/bash

# you may need to make this executable with:
# chmod u+x install_dotfiles.sh

# then to run, use:
# ./install_dotfiles.sh

#mkdir -p ~/.config/nvim/lua/custom/plugins
#ln -i ~/repos/dotfiles/nvim/kickstart_nvim/init.lua ~/.config/nvim/lua/custom/plugins/init.lua

# backup current zshrc
mv ~/.zshrc ~/.zshrc_old

# install zshrc
ln -i ~/repos/dotfiles/.zshrc ~/.zshrc

# link custom dotfiles
ln -i ~/repos/dotfiles/.exports ~/.exports
ln -i ~/repos/dotfiles/.aliases ~/.aliases
ln -i ~/repos/dotfiles/.functions ~/.functions

ln -i ~/repos/dotfiles/.gitconfig ~/.gitconfig
ln -i ~/repos/dotfiles/.gitignore ~/.gitignore
ln -i ~/repos/dotfiles/.inputrc ~/.inputrc
ln -i ~/repos/dotfiles/.npmrc ~/.npmrc
ln -i ~/repos/dotfiles/.tmux.conf ~/.tmux.conf
ln -i ~/repos/dotfiles/.tmux_colors ~/.tmux_colors
ln -i ~/repos/dotfiles/.dircolors ~/.dircolors
ln -i ~/repos/dotfiles/.eslintrc.json ~/.eslintrc.json

# create the "extra" file that contains secrets that SHOULD NOT BE COMMITTED
touch ~/.extra
