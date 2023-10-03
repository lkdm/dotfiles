#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# Dotfile symlinks
ln -fs ~/.dotfiles/.zshrc ~/.zshrc
ln -fs ~/.dotfiles/.gitconfig ~/.gitconfig
mkdir ~/.config/nvim && ln -fs ~/.dotfiles/init.vim ~/.config/nvim/init.vim