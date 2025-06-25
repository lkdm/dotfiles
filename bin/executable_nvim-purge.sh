#!/usr/bin/env bash
# @my
# @about: Purge nvim config and plugins
# @usage: nvim-purge
echo "Purging nvim config and plugins..."
rm ~/.config/nvim -rf
rm ~/.local/share/nvim/lazy -rf
rm ~/.local/share/nvim/mazon -rf
echo "Run `chezmoi apply` to repopulate nvim configuration"
