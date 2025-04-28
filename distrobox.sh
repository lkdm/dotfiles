#!/usr/bin/env bash

# Run inside distrobox to set it up

# Allow use of host 1Password
sudo mkdir -p /opt/1Password
sudo ln -s /run/host/opt/1Password/op-ssh-sign /opt/1Password/
git config --global gpg.ssh.program "/opt/1Password/op-ssh-sign"

# Alias Docker socket
sudo ln -s /var/run/docker.sock /run/host/var/run/docker.sock

# Choose ZSH as default shell
command -v zsh | sudo tee -a /etc/shells # Add zsh to /etc/shells
sudo chsh -s "$(command -v zsh)" "${USER}" # Set zsh as default shell
