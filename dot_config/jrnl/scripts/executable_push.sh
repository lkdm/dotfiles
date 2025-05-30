#!/usr/bin/env bash

JRNL_GIT_DIR=$JRNL

pushd "$JRNL_GIT_DIR" > /dev/null

# Check for ongoing conflict. jrnl will still save, but don't make a commit
if [ -d .git/rebase-merge ] || [ -d .git/rebase-apply ]; then
  printf "\033[0;31m[git rebase in progress: resolve before pushing]\033[0m\n" >&2
  exit 0
fi

git push --quiet
if [ $? -ne 0 ]; then
  printf "\033[0;31m[git push failed]\033[0m\n" >&2
fi

popd > /dev/null
