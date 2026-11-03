# dotfiles
My dev environment: nvim, tmux, zsh, iTerm and Claude Code, all in GitHub Dark colors.

## Setup
1. Install [Homebrew](https://brew.sh) and [Oh My Zsh](https://ohmyz.sh).
2. Run `./install.sh`. It installs the `Brewfile` and symlinks each config, so editing `~/.zshrc` or `~/.config/nvim` edits this repo. Existing files are kept as `*.backup-<date>`.
3. Install [nvm](https://github.com/nvm-sh/nvm) and Node, then `npm i -g typescript typescript-language-server`.
4. iTerm: import `terminal/iterm/iterm_keys.itermkeymap` (Settings > Keys > Key Bindings > Presets) and `terminal/iterm/terminal.json` (Settings > Profiles > Other Actions > Import JSON Profiles). iTerm keeps its own copy, so re-import after editing either file.
5. Claude Code: run `/theme` and pick "GitHub Dark+". For the status line, add `"statusLine": {"type": "command", "command": "~/.claude/statusline.sh"}` to `~/.claude/settings.json`.
6. nvim: `:TSInstall` the languages you need, plus `:Codeium Auth` or `:Copilot auth` for AI completion.

`workspace/ide.json` and `key_bindings.json` are Cursor settings that `install.sh` doesn't link.

## tmux (prefix `C-v`)
| Keys | Does |
| --- | --- |
| `C-t` / `C-d` / `C-f` | Split right / split down / new window, in the current folder (from nvim, the open file's folder) |
| `C-q` / `C-g` | Next pane / previous window |
| `C-w` | Close pane, but keep it running so it can be reopened |
| `prefix T` | Reopen the last closed pane |
| `prefix d` / `prefix f` | Kill pane / window for good |
| `Cmd+F` | Search scrollback, or nvim's `/` inside nvim |
| `Cmd+Shift+F` | Grep the repo and open the hit in nvim |
| `prefix g` | lazygit |

## nvim (leader `Space`)
Space is for actions. Cmd is for motion and regular vim.

| Keys | Does |
| --- | --- |
| `<leader>b` / `Cmd+Shift+E` | Toggle file tree / hop between tree and file |
| `<leader>p` / `P` / `r` | Find file / command palette / recent files |
| `<leader>f` / `F` / `G` / `*` | Search file / project / project with rg flags / word under cursor |
| `<leader>n` / `s` / `w` | New file / save / close tab |
| `Cmd+Shift+,` / `.` | Previous / next tab |
| `<leader>/` / `?` | Toggle comment / AI completion |
| `<leader>h` | Help |
| `:Theme github` / `custom` | Switch color scheme |

**Editing**

| Keys | Does |
| --- | --- |
| `Cmd+←` / `→`, `Option+←` / `→` | Line start / end, back / forward a word |
| `Option+↑` / `↓` | Move line or selection |
| `Shift+arrows`, mouse drag | Select and copy, then `Cmd+V` pastes |
| `<C-q>` in a picker | Send results to quickfix |
| `Esc Esc` | Leave terminal mode |

**Code**

| Keys | Does |
| --- | --- |
| `gd` / `gD` / `gI` | Definition / type definition / implementation |
| `gr` / `K` | References / hover |
| `<leader>rn` / `<leader>.` / `<leader>O` | Rename / code action / symbols in file |
| `F12` / `Shift+F12` / `F2` | Definition / references / rename |

**Git and diffs**

| Keys | Does |
| --- | --- |
| `<leader>dr` / `dR` | Review all changed files in one view / plus untracked. `q` closes |
| `Cmd+→` / `←`, `Cmd+↓` / `↑` | In a review: next / previous file, next / previous change |
| `<leader>dm` / `dd` | Pick a changed file on this branch / uncommitted file, with inline diffs on |
| `<leader>du` / `dq` | Toggle inline diffs for this branch / turn them off |
| `<leader>dc` | Pick a changed file on this branch |
| `]h` / `[h` / `<leader>df` | Next / previous / first hunk. The scrollbar marks where they are |
| `<leader>dp` / `ds` / `dx` / `db` | Preview / stage / reset hunk, blame line |
| `<leader>dh` | File history |

**GitHub PRs (Octo)**

| Keys | Does |
| --- | --- |
| `<leader>o` | PR list |
| `<leader>vp` / `vf` | Full PR diff / changed files |
| `<leader>vs` / `vr` / `vd` | Start or submit a review / resume / discard |
| `<leader>va` | Approve, in the submit window after `Esc` |
| `<leader>ca` / `cr` / `cs` / `cd` | Add comment / reply / suggestion / delete |
| `<leader>ct` / `cT` | Resolve / unresolve thread |
| `<leader>ve` / `vb` / `vm` | Focus files / toggle files / mark viewed |
| `]q` / `[q`, `]t` / `[t` | Next / previous file, next / previous thread |
| `<C-c>` | Close the review |

`<leader>e` tries differ.nvim on the same comment and review keys, `<leader>vo` for its overview. `:Octo review browse` reads a PR without starting a review. Merging only works through `:Octo pr merge`. Less used keys are under `<leader>z`.

**AI**

| Keys | Does |
| --- | --- |
| `<leader>ai` / `ap` | AI completion on or off / switch windsurf and copilot |
| `Tab` | Accept suggestion |
| `<leader>as` / `ab` | Send selection / file to Claude (run `/ide` in Claude first) |
| `<leader>aa` / `ad` | Accept / deny Claude's diff |
