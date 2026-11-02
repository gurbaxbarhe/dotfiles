# Neovim keymaps

- **Space is for actions.** Put every new action under `<leader>`, and suggest Space keys by default. Don't suggest `\` or a new Ctrl key for an action.
- **Cmd is for motion and regular vim.** Cmd shortcuts reach nvim through iTerm's key map (`terminal/iterm/`), which sends keys like Ctrl+A, Ctrl+E or F13.
- **Check for clashes first.** Read the `<leader>` keys in `init.lua` before suggesting one, because a key that extends an existing one (`<Space>pf` over `<Space>p`) doesn't work reliably.
- **Keep plugins with many keys under their own Space prefix.** Keep actions to two keys after Space. Octo's main keys are `<Space>c…` for comments and `<Space>v…` for the review, and the rest sit under `<Space>z` through `maplocalleader`.
