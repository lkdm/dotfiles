#!/usr/bin/env bash
# @my
# @about: Purge nvim config and plugins
# @usage: nvim-purge
echo "Purging nvim config and plugins..."
rm ~/.config/nvim -rf && echo "Purged config"
rm ~/.local/share/nvim/lazy -rf && echo "Purged lazy packages"
rm ~/.local/share/nvim/mazon -rf && echo "Purged mason packages"
echo "Run \`chezmoi apply\` to repopulate nvim configuration"
