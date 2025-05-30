#!/usr/bin/env bash

JRNL_GIT_DIR="$JRNL"

pushd "$JRNL_GIT_DIR" > /dev/null

# Fetch remote updates
git fetch --quiet

# Check if local branch is behind remote
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" != "$REMOTE" ]; then
  git pull --rebase --quiet
  if [ $? -ne 0 ]; then
    printf "\033[0;31m[git pull/rebase failed]\033[0m\n" >&2
  fi
fi

popd > /dev/null

