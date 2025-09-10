#!/usr/bin/env bash

# Will install tmux if it isn't already
brew install tmux

# Clone TPM plugin manager
git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm

tmux start-server
tmux source ~/.config/tmux/tmux.conf
