#!/usr/bin/env bash

# Run inside distrobox to set it up

# Allow use of host 1Password
sudo mkdir -p /opt/1Password
sudo ln -s /run/host/opt/1Password/op-ssh-sign /opt/1Password/
git config --global gpg.ssh.program "/opt/1Password/op-ssh-sign"
