#!/usr/bin/env bash
# work-cleanup - Runs work computer cleanup to comply with ISO audit

[[ " $* " == *" --help "* ]] && cat <<< "work-cleanup - Runs work computer cleanup to comply with ISO audit" && exit 0

# Without nullglob enabled, Bash will pass the literal * as a command, which can cause errors if no files exist
shopt -s nullglob

# Move files in Downloads directory to trash
dirs=(
    ~/Downloads/*
    ~/Pictures/Screenshots/*
    ~/Desktop/*
)

for item in "${dirs[@]}"; do
    # Only trash if the item exists (file or directory)
    if [ -e "$item" ]; then
        gio trash "$item" || true
    fi
done
