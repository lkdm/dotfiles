#!/bin/bash
# Stuff that starts up when shell starts up

# Map Caps Lock to Escape
setxkbmap -option caps:escape

# Fix incompatibility issue with Docker and Ubuntu 22.04 LTS
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0 \
	&& echo "Enabled Docker compatibility mode for newer Ubuntu" \
	&& clear

# Add Nvim to PATH
export PATH=$PATH:/home/luke/bin
# Install Go
export PATH=$PATH:/usr/local/go/bin
# Make Python3 available to Nvim
export PATH=$PATH:/usr/bin/python3

# Force GNOME windows to be dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

# Open the Minitol log, ignoring storage-1 spam
alias mlog="echo \"Listening to container logs...\" && tail -f ~/logs/minitol.out | grep -v storage-1"

# Installs vim in the dev container
function mvim() {
    container_id=$(mid)
    if [ -n "$container_id" ]; then
    docker exec -it "$container_id" bash -c "
        sudo apt-get update
        sudo apt-get install vim
        git config --global core.editor 'vim'
        export GIT_EDITOR=vim
        echo 'Success: Installed Vim in the container'
    "
    else
        echo "Minitol container not found."
    fi
}

# Ensures container user and group id is mapped to host user and group id
export DOCKER_USER="$(id -u):$(id -g)"

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
