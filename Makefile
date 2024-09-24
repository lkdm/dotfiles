.PHONY: neovim osx
DOTFILES_DIR := ~/.dotfiles
NVIM_CONFIG_DIR := ~/.config/nvim

neovim: brew
	@echo "Installing NeoVim"
	brew install neovim
	mkdir -p $(NVIM_CONFIG_DIR)
	ln -fs $(DOTFILES_DIR)/init.vim $(NVIM_CONFIG_DIR)/init.vim
	brew install universal-ctags # Ctags are used for Nvim search. The brew version comes with a recursive option.

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

osx:
	@echo "Setting up OSX"
	defaults write com.apple.Finder AppleShowAllFiles true
	killall Finder
