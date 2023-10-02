#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# Dotfile symlinks
ln -fs ~/.dotfiles/.zshrc ~/.zshrc
ln -fs ~/.dotfiles/.gitconfig ~/.gitconfig

echo -e "# Choose which brewfile to run: \n\
# Personal Brewfile \n\
\t brew bundle --file ~/.dotfiles/brewfile/personal \n\
\n\
# Work Brewfile \n\
\t brew bundle --file ~/.dotfiles/brewfile/work"