#!/usr/bin/env bash
# tmux-new-from-repo.sh
# Show repos/worktrees under ~/Repos with fzf (display-popup), create/attach tmux session named after selection.
set -euo pipefail

root="$HOME/Repos"
[ -d "$root" ] || exit 0

# If not running in a TTY and inside tmux, re-run inside a popup
if [ -n "${TMUX:-}" ] && [ ! -t 0 ]; then
  tmux display-popup -E "$0"
  exit 0
fi

declare -a candidates rels
while IFS= read -r d; do
  [ -d "$d/.git" ] || [ -f "$d/.git" ] || continue
  candidates+=("$d")
done < <(find "$root" -maxdepth 3 -type d 2>/dev/null)

[ ${#candidates[@]} -gt 0 ] || exit 0

declare -A map
for abs in "${candidates[@]}"; do
  rel="${abs#$root/}"
  top="$(printf '%s' "$rel" | cut -d'/' -f1)"
  second="$(printf '%s' "$rel" | cut -d'/' -f2-)"
  if [ -n "$second" ]; then
    display="${top}/${second%%/}"
  else
    display="$rel"
  fi
  if [ -n "${map[$display]:-}" ]; then
    display="$rel"
  fi
  map["$display"]="$abs"
  rels+=("$display")
done

mapfile -t rels < <(printf '%s\n' "${rels[@]}" | awk '!seen[$0]++')

# present with fzf (no preview); cancel -> no-op
sel="$(printf '%s\n' "${rels[@]}" | fzf --height=100% --layout=reverse --border --ansi)"
if [ $? -ne 0 ] || [ -z "${sel:-}" ]; then
  exit 0
fi

sel_abs="${map[$sel]:-}"
[ -z "$sel_abs" ] && sel_abs="$root/$sel"

topdir="$(printf '%s' "$sel" | cut -d'/' -f1)"
repo="$(basename "$sel_abs")"

case "$topdir" in
  TriOnline|TriOnline*|SoftwareNorth|tol) prefix="tol" ;;
  lkdm) prefix="lkdm" ;;
  *) prefix="$(printf '%s' "$topdir" | tr '[:upper:]' '[:lower:]')" ;;
esac

session_name="${prefix}-${repo}"

if tmux has-session -t "$session_name" 2>/dev/null; then
  tmux switch-client -t "$session_name"
else
  tmux new-session -d -s "$session_name" -c "$sel_abs"
  tmux switch-client -t "$session_name"
fi
