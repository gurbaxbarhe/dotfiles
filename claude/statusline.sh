#!/usr/bin/env bash
# Claude Code status line: [model] ❏ repo | ⎇ branch | context bar
input=$(cat)
{ read -r model; read -r dir; read -r pct; } < <(jq -r '.model.display_name, .workspace.current_dir, (.context_window.used_percentage // 0)' <<<"$input")
pct=${pct%%.*}

# Repo name even inside a linked worktree (its common .git lives in the main checkout)
common=$(git -C "$dir" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
if [ -n "$common" ]; then folder=${common%/*}; folder=${folder##*/}; else folder=${dir##*/}; fi
branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)

filled=$((pct / 10))
printf -v full '%*s' "$filled" ''; printf -v empty '%*s' $((10 - filled)) ''
bar=${full// /█}${empty// /░}
# Same colors as nvim's GitHub theme
purple='38;2;210;168;255' blue='38;2;121;192;255' orange='38;2;255;166;87' red='38;2;255;123;114' green='38;2;154;251;161'
if [ "$pct" -ge 80 ]; then color=$red; elif [ "$pct" -ge 50 ]; then color=$orange; else color=$green; fi

printf '\033[%sm[%s]\033[0m ❏ \033[%sm%s\033[0m' "$purple" "$model" "$blue" "$folder"
[ -n "$branch" ] && printf ' | ⎇  \033[%sm%s\033[0m' "$orange" "$branch"
printf ' | \033[%sm%s\033[0m %s%%\n' "$color" "$bar" "$pct"
