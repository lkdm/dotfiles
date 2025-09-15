#!/usr/bin/env bash
# git-rg PATTERN - search tracked files for occurrences of pattern
git ls-files -z | xargs -0 -- grep --color "$@"
