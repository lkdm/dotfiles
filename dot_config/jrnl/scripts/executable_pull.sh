#!/usr/bin/env bash

JRNL_GIT_DIR="$JRNL"
PULL_STAMP_FILE="$JRNL_GIT_DIR/.git/.last_git_pull"
PULL_INTERVAL=900  # 15 minutes in seconds

pushd "$JRNL_GIT_DIR" > /dev/null

now=$(date +%s)
last_pull=0

if [ -f "$PULL_STAMP_FILE" ]; then
  last_pull=$(cat "$PULL_STAMP_FILE")
fi

if (( now - last_pull >= PULL_INTERVAL )); then
  git fetch --quiet

  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u})

  if [ "$LOCAL" != "$REMOTE" ]; then
    git pull --rebase --quiet
    if [ $? -ne 0 ]; then
      printf "\033[0;31m[git pull/rebase failed]\033[0m\n" >&2
    fi
  fi

  echo "$now" > "$PULL_STAMP_FILE"
fi

popd > /dev/null

