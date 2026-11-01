-- The old custom scheme: github_dark tuned to Cursor's "GitHub Dark".
-- Select it with THEME = "custom" in init.lua or :Theme custom.
local M = {}

function M.apply()
  require("github-theme").reset()
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
end

return M
