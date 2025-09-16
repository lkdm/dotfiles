#!/usr/bin/env bash
# tmux-open-lazygit-session - open or create a tmux window running lazygit
set -euo pipefail

win_name="${1:-lazygit}"

# If not inside tmux, just run lazygit in current terminal
if [ -z "${TMUX:-}" ]; then
  exec lazygit
fi

# If a window with that name exists, select it; otherwise create it
if tmux list-windows -F "#{window_name}" 2>/dev/null | grep -Fxq "$win_name"; then
  tmux select-window -t :"$win_name"
else
  tmux new-window -n "$win_name" "lazygit"
fi

# ensure client is on that window
tmux select-window -t :"$win_name"

exit 0
