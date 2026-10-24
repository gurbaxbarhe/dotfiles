# dotfiles
Configs for my dev environment - IDE themes, terminal, tmux, nvim, and keybindings.

## Setup on a new machine
1. Install [Homebrew](https://brew.sh) and [Oh My Zsh](https://ohmyz.sh).
2. Clone this repo and run `./install.sh`. It installs the `Brewfile`, then
   symlinks each config into place (existing files are kept as `*.backup-<date>`).
   Because they're symlinks, editing `~/.zshrc`, `~/.config/nvim`, etc. edits the
   repo directly - just commit.
3. iTerm: Settings > Keys > Key Bindings > Presets > Import `terminal/iterm/iterm_keys.itermkeymap`.
4. Claude Code: `/theme` > "GitHub Dark+" (lighter prompt highlight).
5. nvim: `:Codeium Auth` and/or `:Copilot auth` the first time you use each.

| Repo path | Linked to |
| --- | --- |
| `terminal/zsh/.zshrc`, `gurbax.zsh-theme` | `~/.zshrc`, `~/.oh-my-zsh/custom/themes/` |
| `terminal/tmux/.tmux.conf`, `scripts/` | `~/.tmux.conf`, `~/.tmux/scripts` |
| `nvim/` | `~/.config/nvim` |
| `lazygit/config.yml` | `~/Library/Application Support/lazygit/` |
| `git/delta.gitconfig` | included from `~/.gitconfig` |
| `claude/themes/` | `~/.claude/themes/` |
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

| Keys | Does |
| --- | --- |
| `<leader>f` / `<leader>r` / `<leader>b` | Find files / recent files / open buffers |
| `<leader>g` | Grep the project |
| `<leader>G` | Grep with rg flags: `foo -g '*.ts'`, `"exact phrase" -t py` |
| `<leader>*` / `<leader>/` | Grep word under cursor / fuzzy search this file |
| `Shift+arrows` / `Option+Shift+←→` | Select by character / word (normal or insert); it's already copied, so `Cmd+V` pastes it. A plain arrow ends the selection |
| Mouse drag / double-click | Select text; copied on release, so `Cmd+V` pastes it anywhere |
| `<C-q>` in a picker | Send results to the quickfix list (`:cdo s/a/b/ \| update`) |
| `gd` / `gD` / `gi` | Go to definition / type definition / implementation |
| `gr` / `K` | Find references / hover docs |
| `<leader>s` / `<leader>rn` / `<leader>ca` | Symbols in this file / rename symbol / code action |
| `<leader>dc` | Fuzzy-find files changed on this branch, committed or not |
| `<leader>du` | Toggle the branch's changes inline in this file (deleted lines in red); again to turn off |
| `]h` / `[h` | Next / prev changed hunk |
| `<leader>dp` `ds` `dr` `db` | Preview / stage / reset hunk, blame line |
| `<leader>dd` | Diff working tree (diffview) |
| `<leader>dm` | PR view: everything changed on this branch vs the default branch |
| `]c` / `[c`, `Tab` / `S-Tab` in diffview | Next / prev change, next / prev file |
| `<leader>dh` / `<leader>dq` | File history / close diff |
| `<leader>o` | GitHub PR list (octo) |
| `<leader>ai` / `<leader>ap` | AI completion on/off / switch windsurf <-> copilot |
| `Tab` (insert) | Accept AI suggestion |
| `<leader>as` (visual) / `<leader>ab` | Send selection / buffer to Claude (run `/ide` in Claude first) |
| `<leader>aa` / `<leader>ad` | Accept / deny Claude's proposed diff |
| `Esc Esc` (terminal) | Leave terminal mode |

Reviewing a PR: `gh pr checkout 123`, then `<leader>dm` in nvim (or `prefix g` for lazygit).
