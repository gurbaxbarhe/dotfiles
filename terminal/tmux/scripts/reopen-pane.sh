#!/bin/sh
# Reopen the most recently closed pane (see close-pane.sh) as a new window.
session=$1
last=$(tmux list-windows -t _closed -F '#{window_id}' 2>/dev/null | tr -d @ | sort -n | tail -1)
if [ -z "$last" ]; then
  tmux display-message "Nothing to reopen"
  exit
fi
tmux move-window -s "@$last" -t "$session:"
tmux select-window -t "@$last"
