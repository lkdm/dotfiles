#!/bin/zsh

cd ~/
git clone git@github.com:lkdm/dotfiles.git
mv dotfiles .dotfiles
ln -fs ~/.dotfiles/.zshrc ~/.zshrc
ln -fs ~/.dotfiles/.gitconfig ~/.gitconfig
