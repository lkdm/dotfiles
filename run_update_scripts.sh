#!/usr/bin/env bash

TARGET="$HOME/bin/scripts"
REPO="git@github.com:lkdm/scripts.git"

mkdir -p "$(dirname "$TARGET")"

if [[ -d "$TARGET/.git" ]]; then
  echo "Updating existing repo in $TARGET"
  git -C "$TARGET" pull || { echo "Failed to update repo"; exit 1; }
else
  echo "Cloning repo to $TARGET"
  git clone "$REPO" "$TARGET" || { echo "Failed to clone repo"; exit 1; }
fi

find "$TARGET" -type f -name "*" -exec chmod +x {} +
