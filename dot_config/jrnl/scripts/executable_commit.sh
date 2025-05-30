#!/usr/bin/env bash

JRNL_GIT_DIR=$JRNL

pushd $JRNL_GIT_DIR > /dev/null

# Check for ongoing conflict. jrnl will still save, but don't make a commit
if [ -d .git/rebase-merge ] || [ -d .git/rebase-apply ]; then
  printf "\033[0;31m[git rebase in progress: resolve before committing]\033[0m\n" >&2
  exit 0
fi

if [ -n "$(git status --porcelain)" ]; then
  TITLE=`jrnl -1 \
    --short \
    --config-override timeformat '.' \
    --config-override colors.date none \
    --config-override colors.title none \
    | sed -r 's/^. //'`

  git commit -am "update(jrnl): $TITLE"
fi

popd > /dev/null
