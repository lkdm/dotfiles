#!/usr/bin/env bash
# @my nv-purge(editors) - Purge nvim config and plugins
echo "Purging nvim config and plugins..."
rm ~/.config/nvim -rf && echo "Purged config"
rm ~/.local/share/nvim/lazy -rf && echo "Purged lazy packages"
rm ~/.local/share/nvim/mazon -rf && echo "Purged mason packages"
echo "Run \`chezmoi apply\` to repopulate nvim configuration"
