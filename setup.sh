#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew bundle --file ~/.dotfiles/Brewfile

# Deploys dotfiles to home directory
cd ~/
git clone git@github.com:lkdm/dotfiles.git
mv dotfiles .dotfiles

# Dotfile symlinks
ln -fs ~/.dotfiles/.zshrc ~/.zshrc
ln -fs ~/.dotfiles/.gitconfig ~/.gitconfig
