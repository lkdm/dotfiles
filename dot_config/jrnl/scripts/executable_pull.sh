#!/usr/bin/env bash

JRNL_GIT_DIR=$JRNL

pushd "$JRNL_GIT_DIR" > /dev/null

git pull --quiet
if [ $? -ne 0 ]; then
  printf "\033[0;31m[git pull failed]\033[0m\n" >&2
fi

popd > /dev/null

