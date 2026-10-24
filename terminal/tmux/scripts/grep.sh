#!/usr/bin/env bash
# Project-wide search (Cmd+Shift+F): type to ripgrep the repo, pick a hit, and it
# opens at that line - in the same nvim if you launched this from nvim, else in
# a new window.
dir=$1 pane=$2 cmd=$3
root=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null || echo "$dir")
cd "$root" || exit 1

rg_cmd='rg --hidden --glob=!.git --column --line-number --no-heading --color=always --smart-case'
sel=$(fzf --ansi --disabled --delimiter : --prompt 'grep> ' \
  --header "$root" \
  --bind "change:reload:sleep 0.1; [ -z {q} ] || $rg_cmd -- {q} || true" \
  --preview 'bat --color=always --style=numbers --highlight-line {2} -- {1}' \
  --preview-window 'right,55%,+{2}+3/3') || exit 0

file=$(cut -d: -f1 <<<"$sel")
line=$(cut -d: -f2 <<<"$sel")
[ -n "$file" ] || exit 0

if [ "$cmd" = "nvim" ]; then
  tmux send-keys -t "$pane" Escape ":e +$line $(printf '%q' "$root/$file")" Enter
else
  tmux new-window -c "$root" nvim "+$line" "$root/$file"
fi
