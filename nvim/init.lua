-- Leader must be set before plugins load.
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- nvim-tree replaces netrw, and bufferline needs true color at setup.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      -- The plugin's github_dark drifted to #30363d; these overrides restore the
      -- exact palette from Cursor's "GitHub Dark" (vscode-github-theme dark.json).
      require("github-theme").setup({
        options = { styles = { comments = "italic", keywords = "NONE" } },
        specs = {
          github_dark = {
            bg0 = "#1f2428", -- floats and popups
            bg1 = "#24292e", -- editor background
            bg2 = "#2b3036", -- cursorline
            bg3 = "#2f363d", -- indent guides, folds
            bg4 = "#444d56",
            fg0 = "#959da5",
            fg1 = "#e1e4e8", -- editor foreground
            fg2 = "#959da5", -- statusline
            fg3 = "#444d56", -- line numbers
            sel0 = "#284566", -- visual selection
            sel1 = "#2b3036", -- popup selection
            sel2 = "#5e5632", -- search
            syntax = {
              comment  = "#6a737d",
              const    = "#79b8ff",
              number   = "#79b8ff",
              field    = "#e1e4e8",
              operator = "#f97583",
              builtin0 = "#79b8ff",
              builtin2 = "#79b8ff",
              func     = "#b392f0",
              keyword  = "#f97583",
              conditional = "#f97583",
              statement   = "#f97583",
              preproc     = "#f97583",
              builtin1    = "#f97583",
              string   = "#9ecbff",
              regex    = "#dbedff",
              type     = "#ffab70",
              variable = "#e1e4e8",
              param    = "#ffab70",
              ident    = "#e1e4e8",
              bracket  = "#e1e4e8",
              tag      = "#85e89d",
              dep      = "#fdaeb7",
            },
            diag = { error = "#f97583", warn = "#ffea7f", info = "#79b8ff", hint = "#959da5" },
          },
        },
        -- Per-group overrides. Put the cursor on a token, run :Inspect to get its
        -- @group name, then pin it here. GitHub Dark reference palette:
        --   #b392f0 purple   #ffab70 orange   #79b8ff blue    #9ecbff light blue
        --   #f97583 red      #85e89d green    #e1e4e8 white   #6a737d grey
        groups = {
          github_dark = {
            ["@variable.parameter"] = { fg = "#ffab70" },
            ["@variable.member"] = { fg = "#e1e4e8" },

            -- LSP semantic tokens decide the final color, as in Cursor (VS Code's token->scope rules).
            ["@lsp.type.namespace"]     = { fg = "#b392f0" },
            ["@lsp.type.type"]          = { fg = "#b392f0" },
            ["@lsp.type.struct"]        = { fg = "#b392f0" },
            ["@lsp.type.class"]         = { fg = "#b392f0" },
            ["@lsp.type.interface"]     = { fg = "#b392f0" },
            ["@lsp.type.enum"]          = { fg = "#b392f0" },
            ["@lsp.type.typeParameter"] = { fg = "#b392f0" },
            ["@lsp.type.function"]      = { fg = "#b392f0" },
            ["@lsp.type.method"]        = { fg = "#b392f0" },
            -- ts_ls emits the deprecated "member" alias; superType is "method".
            ["@lsp.type.member"]        = { fg = "#b392f0" },
            ["@lsp.type.macro"]         = { fg = "#b392f0" },
            ["@lsp.type.decorator"]     = { fg = "#b392f0" },
            ["@lsp.type.variable"]      = { fg = "#e1e4e8" },
            ["@lsp.type.property"]      = { fg = "#e1e4e8" },
            ["@lsp.type.event"]         = { fg = "#e1e4e8" },
            ["@lsp.type.parameter"]     = { fg = "#ffab70" },
            ["@lsp.type.enumMember"]    = { fg = "#79b8ff" },
            ["@lsp.type.number"]        = { fg = "#79b8ff" },
            ["@lsp.type.regexp"]        = { fg = "#79b8ff" },
            ["@lsp.type.string"]        = { fg = "#9ecbff" },
            ["@lsp.type.comment"]       = { fg = "#6a737d" },
            ["@lsp.type.keyword"]       = { fg = "#f97583" },
            ["@lsp.type.operator"]      = { fg = "#f97583" },
            -- readonly / defaultLibrary modifiers all resolve to blue
            ["@lsp.typemod.variable.readonly"]         = { fg = "#79b8ff" },
            ["@lsp.typemod.property.readonly"]         = { fg = "#79b8ff" },
            ["@lsp.typemod.variable.defaultLibrary"]   = { fg = "#79b8ff" },
            ["@lsp.typemod.property.defaultLibrary"]   = { fg = "#79b8ff" },
            -- Callables stay purple even from the default library, as in Cursor (.map, console.error).
            ["@lsp.typemod.function.defaultLibrary"]   = { fg = "#b392f0" },
            ["@lsp.typemod.method.defaultLibrary"]     = { fg = "#b392f0" },
            ["@lsp.typemod.member.defaultLibrary"]     = { fg = "#b392f0" },
            ["@lsp.typemod.class.defaultLibrary"]      = { fg = "#79b8ff" },
            ["@lsp.typemod.type.defaultLibrary"]       = { fg = "#79b8ff" },
            ["@lsp.typemod.interface.defaultLibrary"]  = { fg = "#79b8ff" },

            -- Ground truth from running VS Code's tokenizer (vscode-textmate +
            -- Cursor's JS grammar) against dark.json:
            ["@string.escape"]                  = { fg = "#79b8ff" }, -- \n in strings
            ["@string.regexp.delimiter"]        = { fg = "#9ecbff" }, -- the / /
            ["@character.special.javascript"]   = { fg = "#f97583" }, -- regex flags g,i
            ["@character.special.typescript"]   = { fg = "#f97583" },
            ["@character.special.tsx"]          = { fg = "#f97583" },
            ["@operator.regex"]                 = { fg = "#f97583" }, -- + * ? |
            ["@punctuation.delimiter.regex"]    = { fg = "#f97583" }, -- ^ $
            ["@punctuation.bracket.regex"]      = { fg = "#dbedff" }, -- group ( )
            ["@constant.regex"]                 = { fg = "#79b8ff" }, -- chars in [..]
            ["@string.escape.regex"]            = { fg = "#79b8ff" }, -- \d \s \b
            ["@constant.character.escape.regex"] = { fg = "#85e89d" }, -- \[ \] \.
            ["@number.regex"]                   = { fg = "#f97583" }, -- {2,3}
            ["@variable.builtin.regex"]         = { fg = "#79b8ff" }, -- .

            -- Destructuring source keys: `const { a: b }` renders `a` orange.
            ["@ghkey"] = { fg = "#ffab70" },

            -- try/catch/throw/finally are plain keywords in GitHub Dark
            ["@keyword.exception"] = { fg = "#f97583" },

            -- JSDoc: VS Code renders @tag red, the whole {type} purple, names white
            ["@type.jsdoc"]                = { fg = "#b392f0" },
            ["@punctuation.bracket.jsdoc"] = { fg = "#b392f0" },
            ["@punctuation.delimiter.jsdoc"] = { fg = "#e1e4e8" },
            ["@variable.jsdoc"]            = { fg = "#e1e4e8" },
            ["@variable.parameter.jsdoc"]  = { fg = "#e1e4e8" },
            ["@property.jsdoc"]            = { fg = "#e1e4e8" },
            ["@function.jsdoc"]            = { fg = "#e1e4e8" },
            ["@keyword.jsdoc"]             = { fg = "#f97583" },

            -- Bracket-pair colors (editorBracketHighlight.foreground1-6)
            RainbowGH1 = { fg = "#79b8ff" },
            RainbowGH2 = { fg = "#ffab70" },
            RainbowGH3 = { fg = "#b392f0" },

            WinBar   = { fg = "#1f2428", bg = "#477fbf", bold = true },
            WinBarNC = { fg = "#e1e4e8", bg = "#1f2428" },
          },
        },
      })
      vim.cmd("colorscheme github_dark")
    end,
  },

  -- Treesitter: real syntax parsing; without it most tokens stay uncolored.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Fall back to the global typescript when a repo has no local one.
      vim.lsp.config("ts_ls", {
        init_options = {
          hostInfo = "neovim",
          tsserver = { path = vim.fn.expand("~/.nvm/versions/node/v22.22.3/lib/node_modules/typescript/lib/tsserver.js") },
        },
      })
      -- Attach in any git repo, not only ones with a postgres-language-server.jsonc.
      vim.lsp.config("postgres_lsp", { root_markers = { ".git" }, workspace_required = false })
      vim.lsp.enable({ "ts_ls", "eslint", "pyright", "ruff", "postgres_lsp" })
      vim.diagnostic.config({ virtual_text = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local o = function(d) return { buffer = ev.buf, desc = d } end
          local tb = require("telescope.builtin")
          vim.keymap.set("n", "gd", vim.lsp.buf.definition,      o("Go to definition"))
          vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, o("Go to type definition"))
          vim.keymap.set("n", "gr", tb.lsp_references,           o("Find references"))
          vim.keymap.set("n", "gI", tb.lsp_implementations,      o("Go to implementation"))
          vim.keymap.set("n", "K",  vim.lsp.buf.hover,           o("Hover docs"))
          vim.keymap.set("n", "<leader>O", tb.lsp_document_symbols, o("Document symbols"))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,  o("Rename symbol"))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o("Code action"))
          vim.keymap.set("n", "<F12>",   vim.lsp.buf.definition,  o("Go to definition"))
          vim.keymap.set("n", "<S-F12>", tb.lsp_references,       o("Find references"))
          vim.keymap.set("n", "<F2>",    vim.lsp.buf.rename,      o("Rename symbol"))
          vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, o("Code action"))
        end,
      })
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      vim.g.rainbow_delimiters = {
        highlight = { "RainbowGH1", "RainbowGH2", "RainbowGH3" },
        -- VS Code does not colorize brackets inside regexes or ${...}.
        blacklist = { "regex" },
        query = { javascript = "rainbow-gh", typescript = "rainbow-gh", tsx = "rainbow-gh" },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native fzf sorter: same pickers, faster and better-ranked matches.
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- live_grep that accepts rg flags: `foo -g '*.ts'`, `"exact phrase" -t py`
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "%.git/", "node_modules/" },
          -- <C-q> (built in) sends results to the quickfix list; walk them with
          -- :cnext/:cprev or edit all of them with :cdo s/foo/bar/ | update
        },
        pickers = { find_files = { hidden = true } },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")

      local t = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", t.current_buffer_fuzzy_find, { desc = "Search this file" })
      vim.keymap.set("n", "<leader>F", t.live_grep, { desc = "Search the project" })
      vim.keymap.set("n", "<leader>g", t.live_grep,  { desc = "Grep in files" })
      vim.keymap.set("n", "<leader>G", telescope.extensions.live_grep_args.live_grep_args, { desc = "Grep with rg flags" })
      vim.keymap.set("n", "<leader>*", t.grep_string, { desc = "Grep word under cursor" })
      vim.keymap.set("n", "<leader>h", t.help_tags,  { desc = "Help" })
      vim.keymap.set("n", "<leader>r", t.oldfiles,   { desc = "Recent files" })
      -- Files changed on this branch since it left the default branch, committed or not.
      vim.keymap.set("n", "<leader>dc", function()
        local base = vim.trim(vim.fn.system({ "git", "merge-base", "origin/HEAD", "HEAD" }))
        if vim.v.shell_error ~= 0 then
          return vim.notify("No merge base with origin/HEAD", vim.log.levels.WARN)
        end
        t.git_files({ git_command = { "git", "diff", "--name-only", "--relative", base } })
      end, { desc = "Changed files on branch (PR)" })
      vim.keymap.set("n", "<leader>p", t.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>P", t.commands,   { desc = "Command palette" })
    end,
  },

  -- VS Code-style explorer sidebar. Single click opens a file or toggles a folder.
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>b", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file tree" },
      { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal file in tree" },
    },
    opts = {
      view = { width = 40, side = "right" },
      -- Label the root from the repo down (scriptrunner-backend/src), not the full path.
      renderer = {
        root_folder_label = function(path)
          local root = vim.fs.root(path, ".git")
          if not root then return vim.fn.fnamemodify(path, ":t") end
          return vim.fn.fnamemodify(root, ":t") .. path:sub(#root + 1)
        end,
      },
      update_focused_file = { enable = true },
      filters = { dotfiles = false, custom = { "^.git$" } },
      git = { ignore = false },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "<LeftRelease>", api.node.open.edit, { buffer = bufnr, desc = "Open" })
      end,
    },
  },

  -- Pause after Space to see every shortcut that follows it.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>d", group = "Git / diff" },
        { "<leader>a", group = "AI / Claude" },
      },
    },
  },

  -- Open files as tabs along the top.
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "NvimTree", text = "Explorer", separator = true } },
      },
    },
    keys = {
      { "<leader><", function() _G.tab_cycle("<") end, desc = "Previous tab (then < > repeat)" },
      { "<leader>>", function() _G.tab_cycle(">") end, desc = "Next tab (then < > repeat)" },
      { "<leader>w", function()
        -- From the tree (or any non-file window), close the file you were last in.
        local win = vim.api.nvim_get_current_win()
        if not vim.bo.buflisted then win = vim.fn.win_getid(vim.fn.winnr("#")) end
        local buf = win ~= 0 and vim.api.nvim_win_get_buf(win)
        if not buf or not vim.bo[buf].buflisted then return end
        if vim.bo[buf].modified then
          return vim.notify("Unsaved changes, :w first", vim.log.levels.WARN)
        end
        vim.api.nvim_win_call(win, function()
          vim.cmd("bprevious")
          if vim.api.nvim_get_current_buf() == buf then vim.cmd("enew") end
        end)
        vim.cmd("bdelete " .. buf)
      end, desc = "Close tab" },
    },
  },

  -- Git: change markers in the sign column, hunk preview/stage/blame.
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup()
      vim.keymap.set("n", "]h", function() gs.nav_hunk("next") end, { desc = "Next git hunk" })
      vim.keymap.set("n", "[h", function() gs.nav_hunk("prev") end, { desc = "Prev git hunk" })
      vim.keymap.set("n", "<leader>dp", gs.preview_hunk, { desc = "Preview hunk" })
      vim.keymap.set("n", "<leader>ds", gs.stage_hunk,   { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>dr", gs.reset_hunk,   { desc = "Reset hunk" })
      vim.keymap.set("n", "<leader>db", gs.blame_line,   { desc = "Blame line" })
      -- Inline diffs in the file itself, deleted lines in red. No base means uncommitted
      -- changes; a base shows everything since the branch left the default branch.
      local function merge_base()
        local base = vim.trim(vim.fn.system({ "git", "merge-base", "origin/HEAD", "HEAD" }))
        if vim.v.shell_error == 0 then return base end
        vim.notify("No merge base with origin/HEAD", vim.log.levels.WARN)
      end
      local inline = false
      local function set_inline(on, base)
        inline = on
        if base then gs.change_base(base, true) else gs.reset_base(true) end
        gs.toggle_linehl(on)
        gs.toggle_word_diff(on)
        gs.toggle_deleted(on)
      end
      vim.keymap.set("n", "<leader>du", function()
        if inline then return set_inline(false) end
        local base = merge_base()
        if base then set_inline(true, base) end
      end, { desc = "Toggle inline PR diff" })
      vim.keymap.set("n", "<leader>dm", function()
        local base = merge_base()
        if not base then return end
        set_inline(true, base)
        require("telescope.builtin").git_files({ prompt_title = "Changed on branch",
          git_command = { "git", "diff", "--name-only", "--relative", base } })
      end, { desc = "PR changes, inline" })
      vim.keymap.set("n", "<leader>dd", function()
        if vim.fn.system({ "git", "status", "--porcelain" }) == "" then
          return vim.notify("No uncommitted changes")
        end
        set_inline(true)
        require("telescope.builtin").git_status({ prompt_title = "Uncommitted changes" })
      end, { desc = "Uncommitted changes, inline" })
      vim.keymap.set("n", "<leader>dq", function()
        set_inline(false)
        pcall(vim.cmd, "DiffviewClose")
      end, { desc = "Close diff" })
    end,
  },

  -- File history only; diffs are inline through gitsigns.
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
    },
  },

  -- GitHub PRs/issues inside nvim via gh: list, review, comment.
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
      { "<leader>o", "<cmd>Octo pr list<cr>", desc = "GitHub PRs" },
    },
  },

  -- AI ghost-text completion. Both load on demand; lua/ai.lua picks which one
  -- runs (<leader>ai on/off, <leader>ap switch provider).
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    opts = {
      panel = { enabled = false },
      -- <Tab> is owned by lua/ai.lua so the two providers don't fight over it.
      suggestion = { auto_trigger = true, keymap = { accept = false } },
    },
  },
  {
    "Exafunction/windsurf.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        enable_chat = false,
        virtual_text = { enabled = true, map_keys = false },
      })
    end,
  },

  -- Lets the Claude Code session in the next tmux pane see this nvim: run /ide
  -- in Claude to connect. Its edits open here as diffs to accept/deny.
  {
    "coder/claudecode.nvim",
    lazy = false,
    opts = { terminal = { provider = "none" } },
    keys = {
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       mode = "v", desc = "Send selection to Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Add buffer to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny Claude diff" },
    },
  },
})

require("ai").setup()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Claude edits files under open buffers; reload them instead of clobbering on :w.
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermClose", "TermLeave" }, {
  command = "if mode() != 'c' | checktime | endif",
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk — buffer reloaded", vim.log.levels.WARN)
  end,
})

-- Filename bar at the top of each window instead of the bottom statusline.
local MODES = {
  n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE", ["\22"] = "V-BLOCK",
  c = "COMMAND", R = "REPLACE", s = "SELECT", t = "TERMINAL",
}
function _G.winbar()
  local m = vim.api.nvim_get_mode().mode
  local ai = require("ai").status()
  return string.format(" %s  %%f %%m%%=%s  %%l:%%c  %%P ", MODES[m] or m:upper(), ai)
end
-- Set per window, not globally: an empty window-local winbar falls back to the
-- global one, so a global value can't be hidden in side panels like the tree.
vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "WinEnter" }, {
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= "" then return end
    local name = vim.api.nvim_buf_get_name(0)
    local panel = vim.bo.buftype ~= "" or name:match("NvimTree_") or name:match("^diffview://")
    vim.wo.winbar = panel and "" or "%{%v:lua.winbar()%}"
  end,
})
vim.o.laststatus = 0 -- no bottom statusline; winbar replaces it
vim.o.cmdheight = 0  -- windows reach the bottom; the command line shows only while in use
vim.o.ruler = false

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Mac-style selection: Shift+arrows by character, Option+Shift+Left/Right by word.
-- iTerm keeps Cmd+C, so selections copy as they grow (mouse ones on release).
vim.opt.keymodel = "stopsel"
vim.keymap.set("x", "<LeftRelease>", "<LeftRelease>ygv")
vim.keymap.set("x", "<2-LeftRelease>", "<2-LeftRelease>ygv")
-- { first press (one char, like a Mac), each press after }; `^ is where insert left the cursor.
for key, m in pairs({ ["<S-Left>"] = { "hv", "h" }, ["<S-Right>"] = { "v", "l" },
                      ["<S-Up>"] = { "vk", "k" }, ["<S-Down>"] = { "vj", "j" },
                      ["<M-S-Left>"] = { "vb", "b" }, ["<M-S-Right>"] = { "ve", "e" } }) do
  vim.keymap.set("n", key, m[1] .. "ygv")
  vim.keymap.set("i", key, "<Esc>`^" .. m[1] .. "ygv")
  vim.keymap.set("x", key, m[2] .. "ygv")
end

-- Cursor shortcuts as Space + the same key (Cmd+S -> Space s, Cmd+/ -> Space /).
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("n", "<leader>n", function()
  local dir = vim.bo.buflisted and vim.fn.expand("%:.:h") or ""
  dir = (dir == "" or dir == ".") and "" or dir .. "/"
  vim.ui.input({ prompt = "New file: ", default = dir, completion = "file" }, function(path)
    if not path or path == "" or path:sub(-1) == "/" then return end
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    vim.cmd.edit(vim.fn.fnameescape(path))
  end)
end, { desc = "New file" })
-- After Space+< or Space+>, keep pressing < or > to cycle tabs; any other key ends it and runs.
function _G.tab_cycle(key)
  while key == "<" or key == ">" do
    vim.cmd(key == "<" and "BufferLineCyclePrev" or "BufferLineCycleNext")
    vim.cmd.redraw()
    local ok, next_key = pcall(vim.fn.getcharstr)
    if not ok then return end
    key = next_key
  end
  vim.api.nvim_feedkeys(key, "m", false)
end
-- Mac line/word jumps: iTerm sends Ctrl+A / Ctrl+E for Cmd+Left / Cmd+Right.
for _, k in ipairs({ { "<C-a>", "^", "<C-o>^" }, { "<C-e>", "$", "<End>" },
                     { "<M-Left>", "b", "<C-o>b" }, { "<M-Right>", "e", "<C-o>e<Right>" } }) do
  vim.keymap.set({ "n", "x" }, k[1], k[2])
  vim.keymap.set("i", k[1], k[3])
end
vim.keymap.set("n", "<M-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("n", "<M-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("i", "<M-Up>", "<Esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<M-Down>", "<Esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
vim.keymap.set("x", "<M-Up>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
vim.keymap.set("x", "<M-Down>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })

-- Tell tmux which folder this pane is "in" (the current file's), so tmux
-- splits from an nvim pane open there instead of where nvim was launched.
if vim.env.TMUX then
  local function set_tmux_dir(dir)
    vim.system({ "tmux", "set-option", "-p", "-t", vim.env.TMUX_PANE, "@nvim_dir", dir })
  end
  vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
    callback = function()
      local dir = vim.fn.expand("%:p:h")
      if vim.bo.buftype ~= "" or vim.fn.isdirectory(dir) == 0 then dir = vim.fn.getcwd() end
      set_tmux_dir(dir)
    end,
  })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      vim.system({ "tmux", "set-option", "-p", "-u", "-t", vim.env.TMUX_PANE, "@nvim_dir" }):wait()
    end,
  })
end
