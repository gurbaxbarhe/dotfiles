#!/bin/sh
# Close a pane by parking it in the hidden "_closed" session instead of killing
# it, so reopen-pane.sh can bring it back with its process still running.
# The last pane of a session is killed for real so the session can end.
pane=$1 session_windows=$2 window_panes=$3
KEEP=10

if [ "$session_windows" -le 1 ] && [ "$window_panes" -le 1 ]; then
  tmux kill-pane -t "$pane"
  exit
fi

if tmux has-session -t _closed 2>/dev/null; then
  tmux break-pane -d -s "$pane" -t _closed:
else
  tmux new-session -d -s _closed
  placeholder=$(tmux list-windows -t _closed -F '#{window_id}')
  tmux break-pane -d -s "$pane" -t _closed:
  tmux kill-window -t "$placeholder"
fi

# Window ids only grow, so the lowest ids are the oldest parked panes.
tmux list-windows -t _closed -F '#{window_id}' | tr -d @ | sort -n | sed "s/^/@/" |
  awk -v keep="$KEEP" '{ ids[NR] = $0 } END { for (i = 1; i <= NR - keep; i++) print ids[i] }' |
  while read -r old; do tmux kill-window -t "$old"; done
