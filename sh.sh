#!/bin/bash
# Stuff that starts up when shell starts up

# Add Nvim to PATH
export PATH=$PATH:/home/luke/bin
# Install Go
export PATH=$PATH:/usr/local/go/bin
# Make Python3 available to Nvim
export PATH=$PATH:/usr/bin/python3

# Force GNOME windows to be dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

# Alias to instantiate dev containers
alias toi="docker exec -it $(docker ps -q --filter expose=8001) zsh"

# Set the default editor to Neovim
export VISUAL=nvim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

# Remove unsightly green highlight from directories
# This made the text illegible
export LS_COLORS=$LS_COLORS:'ow=1;34:'















. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
