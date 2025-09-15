#!/usr/bin/env bash
# upgrade - run system and software update scripts

# Helper for prefixing output
# Used to prefix logs with a label
prefix() {
  local tag="$1"
  awk -v tag="$tag" '{printf "%8s | %s\n", tag, $0}'
}

local OS_RELEASE=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
echo "Starting system upgrade..." | prefix system
if [ "$OS_RELEASE" = "bluefin" ]; then
    echo "Upgrading Bluefin..." | prefix system
    ujust upgrade 2>&1 | prefix system
fi

if [ "$OS_RELEASE" = "bazzite" ]; then
    echo "Upgrading Bazzite..." | prefix system
    ujust upgrade 2>&1 | prefix system
fi

if [ "$OS_RELEASE" = "debian" ]; then
    echo "Upgrading Debian..." | prefix system
    sudo apt update && sudo apt upgrade -y 2>&1 | prefix system
fi

command -v cargo &>/dev/null && {
    {
    echo "Starting cargo upgrade..."
    command -v cargo-install-update &>/dev/null || {
        echo "Installing cargo-update..."
        cargo install cargo-update
    }
    command -v cargo-install-update &>/dev/null && cargo install-update -a
    } 2>&1 | prefix cargo &
}

command -v flatpak &>/dev/null && flatpak update -y 2>&1 | prefix flatpak &
command -v brew &>/dev/null && brew update && brew upgrade 2>&1 | prefix brew &
command -v mas &>/dev/null && mas upgrade 2>&1 | prefix mas &
command -v chezmoi &>/dev/null && chezmoi git pull 2>&1 | prefix chezmoi &

wait
echo "✅ All updates completed.\n\nIf you have appimages, use gearlever to upgrade them." | prefix script

