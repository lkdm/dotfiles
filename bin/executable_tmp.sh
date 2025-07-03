#!/usr/bin/env bash
# @my
# @about: Create a temporary directory, open a shell, then destroy it on exit
# @usage: tmp

dir="$(mktemp -d "${TMPDIR:-/tmp}/$1.XXXXXX")" || { echo "mktemp failed"; return 1; }
echo "Opening a new shell in $dir. Use command `exit` to return."
(
	cd "$dir" || exit 1
	trap 'cd /; rm -rf "$dir"' EXIT
	export NO_MOTD=1
	"${SHELL:-/bin/bash}"
)
