#!/usr/bin/env bash
# Set up this machine from the dotfiles repo: install tools from the Brewfile,
# then symlink every config into place so edits land straight in the repo.
# Safe to re-run. Anything already at a target is moved to <target>.backup-<date>.
#   ./install.sh            brew bundle + links
#   ./install.sh --no-brew  links only
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$DOTFILES/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok      $dest"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.backup-$STAMP"
    echo "backup  $dest -> $dest.backup-$STAMP"
  fi
  ln -s "$src" "$dest"
  echo "link    $dest -> $src"
}

if [ "${1:-}" != "--no-brew" ]; then
  if command -v brew >/dev/null; then
    brew bundle --file="$DOTFILES/Brewfile"
  else
    echo "Homebrew not found; install it from https://brew.sh then re-run." >&2
    exit 1
  fi
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh not found; install it from https://ohmyz.sh then re-run." >&2
  exit 1
fi

link terminal/zsh/.zshrc           "$HOME/.zshrc"
link terminal/zsh/gurbax.zsh-theme "$HOME/.oh-my-zsh/custom/themes/gurbax.zsh-theme"

link terminal/tmux/.tmux.conf "$HOME/.tmux.conf"
link terminal/tmux/scripts    "$HOME/.tmux/scripts"

link nvim                   "$HOME/.config/nvim"
link workspace/.nanorc      "$HOME/.nanorc"
link workspace/nano-syntax  "$HOME/.nano-syntax"

# Git: delta as the pager, pulled in with an include so ~/.gitconfig keeps
# your identity and credentials.
link lazygit/config.yml "$HOME/Library/Application Support/lazygit/config.yml"
if ! git config --global --get-all include.path | grep -qxF "$DOTFILES/git/delta.gitconfig"; then
  git config --global --add include.path "$DOTFILES/git/delta.gitconfig"
  echo "include ~/.gitconfig -> git/delta.gitconfig"
fi

# Claude Code theme (pick it with /theme)
link claude/themes/github-dark-plus.json "$HOME/.claude/themes/github-dark-plus.json"
# Status line; enable with "statusLine": {"type": "command", "command": "~/.claude/statusline.sh"} in settings.json
link claude/statusline.sh "$HOME/.claude/statusline.sh"

# iTerm: Cmd+Option+D maximizes / restores the current split pane
defaults write com.googlecode.iterm2 NSUserKeyEquivalents -dict-add "Maximize Active Pane" "@~d"

if [ -n "${TMUX:-}" ]; then
  tmux source-file "$HOME/.tmux.conf" && echo "tmux config reloaded"
fi

cat <<'EOF'

Done. Manual steps:
  - iTerm: Settings > Keys > Key Bindings > Presets > Import...
    and pick terminal/iterm/iterm_keys.itermkeymap (Cmd+F, Cmd+Shift+F, Cmd+Shift+T)
  - Claude Code: /theme > "GitHub Dark+"
  - nvim: :Codeium Auth (windsurf) and/or :Copilot auth on first use
EOF
