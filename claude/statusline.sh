#!/usr/bin/env bash
# Claude Code status line: [model] 📁 repo | ⎇ branch | context bar
input=$(cat)
model=$(jq -r '.model.display_name' <<<"$input")
dir=$(jq -r '.workspace.current_dir' <<<"$input")
pct=$(jq -r '.context_window.used_percentage // 0' <<<"$input" | cut -d. -f1)

# Repo name even inside a linked worktree (its common .git lives in the main checkout)
common=$(git -C "$dir" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
if [ -n "$common" ]; then folder=$(basename "$(dirname "$common")"); else folder=$(basename "$dir"); fi
branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)

filled=$((pct / 10))
bar=$(printf '%*s' "$filled" '' | tr ' ' '█')$(printf '%*s' $((10 - filled)) '' | tr ' ' '░')
if [ "$pct" -ge 80 ]; then color=31; elif [ "$pct" -ge 50 ]; then color=33; else color=32; fi

printf '\033[36m[%s]\033[0m 📁 %s' "$model" "$folder"
[ -n "$branch" ] && printf ' | ⎇ %s' "$branch"
printf ' | \033[%sm%s\033[0m %s%%\n' "$color" "$bar" "$pct"
