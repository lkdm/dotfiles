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

LOGDIR="${XDG_STATE_HOME:-$HOME/.local/state}/my-upgrade"
mkdir -p "$LOGDIR"
LOGFILE="$LOGDIR/upgrade.log"
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOGFILE"
}

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
    log "[INFO] Starting: ujust upgrade"
    if run_on_host command -v ujust &>/dev/null; then
        echo "Running Universal Blue's ujust update on host..."
        log "[INFO] ujust found on host. Running update."
        run_on_host ujust update && log "[INFO] ujust update completed" || log "[ERROR] ujust update failed"
    else
        echo "ujust not found on host. Skipping Universal Blue's system update."
        log "[WARN] ujust not found on host. Skipped Universal Blue's system update."
    fi
    log "[INFO] Finished: ujust upgrade"
}

upgrade_homebrew() {
    log "[INFO] Starting: Homebrew upgrade"
    if run_on_host command -v brew &>/dev/null; then
        echo "Upgrading Homebrew on host..."
        log "[INFO] Homebrew found on host. Running upgrade."
        run_on_host brew update && run_on_host brew upgrade && log "[INFO] Homebrew upgrade completed" || log "[ERROR] Homebrew upgrade failed"
    else
        echo "Homebrew not found on host. Skipping."
        log "[WARN] Homebrew not found on host. Skipped upgrade."
    fi
    log "[INFO] Finished: Homebrew upgrade"
}

upgrade_mas() {
    log "[INFO] Starting: mas (Mac App Store) upgrade"
    if run_on_host command -v mas &>/dev/null; then
        echo "Upgrading Mac App Store apps with mas..."
        log "[INFO] mas found on host. Running upgrade."
        run_on_host mas upgrade && log "[INFO] mas upgrade completed" || log "[ERROR] mas upgrade failed"
    else
        echo "mas not found on host. Skipping Mac App Store app upgrades."
        log "[WARN] mas not found on host. Skipped Mac App Store upgrades."
    fi
    log "[INFO] Finished: mas upgrade"
}

upgrade_flatpak() {
    log "[INFO] Starting: Flatpak upgrade"
    if run_on_host command -v flatpak &>/dev/null; then
        echo "Upgrading Flatpak apps on host..."
        log "[INFO] Flatpak found on host. Running upgrade."
        run_on_host flatpak update -y && log "[INFO] Flatpak upgrade completed" || log "[ERROR] Flatpak upgrade failed"
    else
        echo "Flatpak not found on host. Skipping."
        log "[WARN] Flatpak not found on host. Skipped upgrade."
    fi
    log "[INFO] Finished: Flatpak upgrade"
}

upgrade_distrobox() {
    log "[INFO] Starting: Distrobox containers upgrade"
    if run_on_host command -v distrobox-upgrade &>/dev/null; then
        echo "Upgrading all Distrobox containers..."
        log "[INFO] distrobox-upgrade found. Running upgrade."
        run_on_host distrobox-upgrade --all && log "[INFO] Distrobox containers upgraded" || log "[ERROR] distrobox-upgrade failed"
    else
        log "[WARN] distrobox-upgrade not found. Skipped containers upgrade."
    fi
    log "[INFO] Finished: Distrobox containers upgrade"
}

upgrade_brew_in_distroboxes() {
    log "[INFO] Starting: Homebrew upgrade in Distrobox containers"
    run_in_distroboxes '
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

if command -v brew &>/dev/null; then
  echo "  Homebrew found. Upgrading..."
  brew update && brew upgrade && echo "[INFO] Homebrew upgrade completed in container" || echo "[ERROR] Homebrew upgrade failed in container"
elif [ -f "$HOME/.linuxbrew/bin/brew" ]; then
  eval "$($HOME/.linuxbrew/bin/brew shellenv)"
  brew update && brew upgrade && echo "[INFO] Homebrew upgrade completed in container" || echo "[ERROR] Homebrew upgrade failed in container"
elif [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew update && brew upgrade && echo "[INFO] Homebrew upgrade completed in container" || echo "[ERROR] Homebrew upgrade failed in container"
else
  echo "  Homebrew not found in this container. Skipping."
fi
'
    log "[INFO] Finished: Homebrew upgrade in Distrobox containers"
}

upgrade_cargo_in_distroboxes() {
    log "[INFO] Starting: Cargo upgrade in Distrobox containers"
    run_in_distroboxes '
export PATH="$HOME/.cargo/bin:/home/linuxbrew/.linuxbrew/opt/rustup/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"
if command -v cargo-install-update &>/dev/null; then
    cargo install-update -a && echo "[INFO] cargo install-update completed" || echo "[ERROR] cargo install-update failed"
elif command -v cargo &>/dev/null; then
    echo "cargo install-update subcommand missing"
    exit 1
else
    echo "  Cargo not found in this container. Skipping."
fi
'
    log "[INFO] Finished: Cargo upgrade in Distrobox containers"
}

# --- Main Routine ---

log "[INFO] Upgrade run started"

upgrade_ujust
upgrade_homebrew
upgrade_flatpak
upgrade_distrobox
upgrade_brew_in_distroboxes
upgrade_cargo_in_distroboxes
upgrade_mas

wait

log "[INFO] Upgrade run completed"

