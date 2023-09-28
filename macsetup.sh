#!/bin/bash

# Install Homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# Finder: Show hidden files
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

# Commandline tools
brew install zsh git wget tree neovim htop

# Install apps
brew install --cask visual-studio-code
brew install --cask iterm2
brew install --cask appcleaner
brew install --cask iina

# NVM
brew install nvm
mkdir ~/.nvm
nvm install stable

# Disable press and hold for keys in VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Install fonts
brew tap homebrew/cask-fonts &&
    brew install --cask font-CascadiaCode-nerd-font