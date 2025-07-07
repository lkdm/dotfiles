#!/usr/bin/env bash
# @my upgrade(utils) - Upgrade host packages and containers, and their packages.

if [[ " $* " == *" --help "* || " $* " == *" -h "* ]]; then
    cat <<EOF
upgrade - Upgrade host system and packages.

This script:
  - Upgrades the host OS and all supported package managers (e.g., Homebrew, Flatpak, mas, etc.)
  - If Distrobox containers are present, upgrades their packages as well
  - Handles both host and container upgrades seamlessly

Usage:
  $0 [--help|-h]

EOF
    exit 0
fi


set -euo pipefail

# --- Utility Functions ---

run_on_host() {
    # Runs a command on the host, even if inside Distrobox
    if [ -n "${DISTROBOX_ENTER_PATH:-}" ]; then
        distrobox-host-exec "$@"
    else
        "$@"
    fi
}

run_in_distroboxes() {
    local cmd="$1"

    if ! run_on_host command -v distrobox &>/dev/null; then
        echo "Distrobox not found. Skipping container commands."
        return
    fi

    containers=$(run_on_host distrobox list | awk 'NR>1 {print $1}')
    if [[ -z "$containers" ]]; then
        echo "No Distrobox containers found. Nothing to do."
        return
    fi

    for name in $containers; do
        echo "Running in container [$name]: $cmd"
        run_on_host distrobox enter -H -n "$name" -- bash -c "$cmd"
    done
}

# --- Upgrade Routines ---

upgrade_ujust() {
    if run_on_host command -v ujust &>/dev/null; then
        echo "Running Universal Blue's ujust update on host..."
        run_on_host ujust update
    else
        echo "ujust not found on host. Skipping Universal Blue's system update."
    fi
}

upgrade_homebrew() {
    if run_on_host command -v brew &>/dev/null; then
        echo "Upgrading Homebrew on host..."
        run_on_host brew update && run_on_host brew upgrade &
    else
        echo "Homebrew not found on host. Skipping."
    fi
}

upgrade_mas() {
    if run_on_host command -v mas &>/dev/null; then
        echo "Upgrading Mac App Store apps with mas..."
        run_on_host mas upgrade
    else
        echo "mas not found on host. Skipping Mac App Store app upgrades."
    fi
}

upgrade_flatpak() {
    if run_on_host command -v flatpak &>/dev/null; then
        echo "Upgrading Flatpak apps on host..."
        run_on_host flatpak update -y
    else
        echo "Flatpak not found on host. Skipping."
    fi
}

upgrade_distrobox() {
    if run_on_host command -v distrobox-upgrade &>/dev/null; then
        echo "Upgrading all Distrobox containers..."
        run_on_host distrobox-upgrade --all
    fi
}


upgrade_brew_in_distroboxes() {
	run_in_distroboxes '
	if [ -f "$HOME/.profile" ]; then
    	source "$HOME/.profile"
	fi

	if command -v brew &>/dev/null; then
  	brew update && brew upgrade
	elif [ -f "$HOME/.linuxbrew/bin/brew" ]; then
  	eval "$($HOME/.linuxbrew/bin/brew shellenv)"
  	brew update && brew upgrade
	elif [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  	brew update && brew upgrade
	else
  	echo "  Homebrew not found in this container. Skipping."
	fi
	'
}

upgrade_cargo_in_distroboxes() {
	run_in_distroboxes '
	export PATH="$HOME/.cargo/bin:/home/linuxbrew/.linuxbrew/opt/rustup/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"
	if command -v cargo-install-update &>/dev/null; then
    	cargo install-update -a
	elif command -v cargo &>/dev/null; then
    	pkgs=$(cargo install --list | awk "/:$/ { print \$1 }")
    	if [ -n "$pkgs" ]; then
        	cargo install $pkgs
    	else
        	echo "  No Cargo binaries installed. Skipping."
    	fi
	else
    	echo "  Cargo not found in this container. Skipping."
	fi
	'
}

# --- Main Routine ---

upgrade_ujust
upgrade_homebrew
upgrade_flatpak
upgrade_distrobox
upgrade_brew_in_distroboxes
upgrade_cargo_in_distroboxes
upgrade_mas

wait

# --- Add more upgrade routines below as needed ---

