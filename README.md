# dotfiles
Configs for my dev environment - IDE themes, terminal, tmux, nvim, and keybindings.

## Setup on a new machine
1. Install [Homebrew](https://brew.sh) and [Oh My Zsh](https://ohmyz.sh).
2. Clone this repo and run `./install.sh`. It installs the `Brewfile`, then
   symlinks each config into place (existing files are kept as `*.backup-<date>`).
   Because they're symlinks, editing `~/.zshrc`, `~/.config/nvim`, etc. edits the
   repo directly - just commit.
3. iTerm: Settings > Keys > Key Bindings > Presets > Import `terminal/iterm/iterm_keys.itermkeymap`,
   and Settings > Profiles > Other Actions > Import JSON Profiles > `terminal/iterm/terminal.json`
   (Menlo 13, with Symbols Nerd Font Mono for non-ASCII so nvim's file icons render).
4. Claude Code: `/theme` > "GitHub Dark+" (lighter prompt highlight).
5. nvim: `:Codeium Auth` and/or `:Copilot auth` the first time you use each.

| Repo path | Linked to |
| --- | --- |
| `terminal/zsh/.zshrc`, `gurbax.zsh-theme` | `~/.zshrc`, `~/.oh-my-zsh/custom/themes/` |
| `terminal/tmux/.tmux.conf`, `scripts/` | `~/.tmux.conf`, `~/.tmux/scripts` |
| `nvim/` | `~/.config/nvim` |
| `lazygit/config.yml` | `~/Library/Application Support/lazygit/` |
| `git/delta.gitconfig` | included from `~/.gitconfig` |
| `claude/themes/`, `statusline.sh` | `~/.claude/themes/`, `~/.claude/statusline.sh` |
| `workspace/.nanorc`, `nano-syntax/` | `~/.nanorc`, `~/.nano-syntax` |

## Shortcuts

### Terminal (tmux prefix is `C-v`)
| Keys | Does |
| --- | --- |
| `C-t` / `C-d` | Split right / down, in the current pane's folder (from nvim: the open file's folder) |
| `C-f` | New window, same folder |
| `C-w` | Close pane (parked, so it can be reopened) |
| `Cmd+Shift+T` (`prefix T`) | Reopen the last closed pane, process and all |
| `Cmd+F` (`prefix /`) | Search scrollback (`n`/`N` next/prev); inside nvim, nvim's `/` |
| `Cmd+Shift+F` (`prefix F`) | Grep the repo, open the hit in nvim |
| `prefix g` | lazygit popup |
| `prefix d` / `prefix f` | Kill pane / window for good |

### nvim (leader is `Space`)
`<leader>dm` means press `Space`, `d`, `m` one after another in normal mode, within about a second.
Keys without `<leader>` (`]h`, `gd`) are typed as written.

**Cursor shortcuts:** replace `Cmd` with `Space`, keep the Shift and the key. Tap `Space` and let go, then press the rest.

| Cursor | nvim | Does |
| --- | --- | --- |
| `Cmd+B` | `Space+B` | Show / hide the file tree. Click a file to open it, a folder to expand it |
| `Cmd+Shift+E` | `Space+Shift+E` | Open the file tree with the current file highlighted |
| `Cmd+P` | `Space+P` | Find a file by name |
| `Cmd+Shift+P` | `Space+Shift+P` | Command palette: search every nvim command |
| `Cmd+F` | `Space+F` | Search inside this file |
| `Cmd+Shift+F` | `Space+Shift+F` | Search text across the whole project |
| `Cmd+N` | `Space+N` | New file: asks for a name, starting in the current file's folder |
| `Cmd+S` | `Space+S` | Save the file |
| `Cmd+W` | `Space+W` | Close the current tab (warns if unsaved) |
| `Cmd+Shift+[` / `]` | `Cmd+Shift+,` / `.` | Previous / next tab, wrapping around; hold Cmd+Shift and tap to keep going (iTerm sends F13 / F14) |
| `Cmd+Z` / `Cmd+Shift+Z` | `u` / `Ctrl+R` | Undo / redo |
| `Cmd+/` | `Space+/` | Comment / uncomment the line, or the selected lines |
| `Cmd+Shift+/` | `Space+Shift+/` | Turn AI autocomplete (Cursor Tab) on / off |
| `Cmd+.` | `Space+.` | Quick fix: code actions for the error or symbol under the cursor |
| `Cmd+Shift+O` | `Space+Shift+O` | Jump to a function, class or variable in this file |
| `F12` / `Shift+F12` | same | Go to definition / list everywhere it's used |
| `F2` | same | Rename the symbol everywhere it's used |
| `Option+↑` / `↓` | same | Move the line or selection up / down |
| `Cmd+←` / `→` | same | Start / end of the line (normal, insert and visual) |
| `Option+←` / `→` | same | Back / forward a word |

| Keys | Does |
| --- | --- |
| `<leader>r` | Recent files |
| `<leader>g` | Grep the project |
| `<leader>G` | Grep with rg flags: `foo -g '*.ts'`, `"exact phrase" -t py` |
| `<leader>*` | Grep word under cursor |
| `Shift+arrows` / `Option+Shift+←→` | Select by character / word (normal or insert); it's already copied, so `Cmd+V` pastes it. A plain arrow ends the selection |
| Mouse drag / double-click | Select text; copied on release, so `Cmd+V` pastes it anywhere |
| `<C-q>` in a picker | Send results to the quickfix list (`:cdo s/a/b/ \| update`) |
| `gd` / `gD` / `gI` | Go to definition / type definition / implementation |
| `gr` / `K` | Find references / hover docs |
| `<leader>rn` / `<leader>ca` | Rename symbol / code action |
| `<leader>dc` | Fuzzy-find files changed on this branch, committed or not |
| `<leader>du` | Toggle the branch's changes inline in this file (deleted lines in red); again to turn off |
| `]h` / `[h` | Next / prev changed hunk |
| `<leader>dp` `ds` `dr` `db` | Preview / stage / reset hunk, blame line |
| `<leader>dm` | PR view: list the branch's changed files; each opens with its changes inline |
| `<leader>dd` | Same for uncommitted changes |
| `<leader>dq` | Turn inline diffs off |
| `<leader>dh` | File history (diffview) |
| `<leader>o` | GitHub PR list (octo) |
| `<leader>ai` / `<leader>ap` | AI completion on/off / switch windsurf <-> copilot |
| `Tab` (insert) | Accept AI suggestion |
| `<leader>as` (visual) / `<leader>ab` | Send selection / buffer to Claude (run `/ide` in Claude first) |
| `<leader>aa` / `<leader>ad` | Accept / deny Claude's proposed diff |
| `Esc Esc` (terminal) | Leave terminal mode |

Reviewing a PR: `gh pr checkout 123`, then `<leader>dm` in nvim (or `prefix g` for lazygit).
