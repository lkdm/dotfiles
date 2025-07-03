#!/usr/bin/env bash
# @my tmp(utils) - Open a shell in a tmp dir, destroying it on exit

dir="$(mktemp -d "${TMPDIR:-/tmp}/$1.XXXXXX")" || { echo "mktemp failed"; return 1; }
echo "Opening a new shell in $dir. Use command `exit` to return."
(
	cd "$dir" || exit 1
	trap 'cd /; rm -rf "$dir"' EXIT
	export NO_MOTD=1
	"${SHELL:-/bin/bash}"
)
