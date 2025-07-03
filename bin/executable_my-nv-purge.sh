#!/usr/bin/env bash
# @my nv-purge(editors) - Purge nvim config and plugins

[[ " $* " == *" --help "* ]] && cat <<< "nv-purge - Purges Neovim configuration directory, Mason plugins directory, and Lazy plugins directory." && exit 0

echo "Purging nvim config and plugins..."
rm ~/.config/nvim -rf && echo "Purged config"
rm ~/.local/share/nvim/lazy -rf && echo "Purged lazy packages"
rm ~/.local/share/nvim/mazon -rf && echo "Purged mason packages"
echo "Run \`chezmoi apply\` to repopulate nvim configuration"
