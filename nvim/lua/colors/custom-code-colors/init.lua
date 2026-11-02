-- The old custom scheme: github_dark tuned to Cursor's "GitHub Dark".
-- Select it with THEME = "custom" in init.lua or :Theme custom.
local M = {}

local BLUE, PURPLE, RED, WHITE, ORANGE = "#79b8ff", "#b392f0", "#f97583", "#e1e4e8", "#ffab70"

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
        fg1 = WHITE, -- editor foreground
        fg2 = "#959da5", -- statusline
        fg3 = "#444d56", -- line numbers
        sel0 = "#284566", -- visual selection
        sel1 = "#2b3036", -- popup selection
        sel2 = "#5e5632", -- search
        syntax = {
          comment  = "#6a737d",
          const    = BLUE,
          number   = BLUE,
          field    = WHITE,
          operator = RED,
          builtin0 = BLUE,
          builtin2 = BLUE,
          func     = PURPLE,
          keyword  = RED,
          conditional = RED,
          statement   = RED,
          preproc     = RED,
          builtin1    = RED,
          string   = "#9ecbff",
          regex    = "#dbedff",
          type     = ORANGE,
          variable = WHITE,
          param    = ORANGE,
          ident    = WHITE,
          bracket  = WHITE,
          tag      = "#85e89d",
          dep      = "#fdaeb7",
        },
        diag = { error = RED, warn = "#ffea7f", info = BLUE, hint = "#959da5" },
      },
    },
    -- Per-group overrides. Put the cursor on a token, run :Inspect to get its
    -- @group name, then pin it here. GitHub Dark reference palette:
    --   #b392f0 purple   #ffab70 orange   #79b8ff blue    #9ecbff light blue
    --   #f97583 red      #85e89d green    #e1e4e8 white   #6a737d grey
    groups = {
      github_dark = {
        ["@variable.parameter"] = { fg = ORANGE },
        ["@variable.member"] = { fg = WHITE },

        -- LSP semantic tokens decide the final color, as in Cursor (VS Code's token->scope rules).
        ["@lsp.type.namespace"]     = { fg = PURPLE },
        ["@lsp.type.type"]          = { fg = PURPLE },
        ["@lsp.type.struct"]        = { fg = PURPLE },
        ["@lsp.type.class"]         = { fg = PURPLE },
        ["@lsp.type.interface"]     = { fg = PURPLE },
        ["@lsp.type.enum"]          = { fg = PURPLE },
        ["@lsp.type.typeParameter"] = { fg = PURPLE },
        ["@lsp.type.function"]      = { fg = PURPLE },
        ["@lsp.type.method"]        = { fg = PURPLE },
        -- ts_ls emits the deprecated "member" alias; superType is "method".
        ["@lsp.type.member"]        = { fg = PURPLE },
        ["@lsp.type.macro"]         = { fg = PURPLE },
        ["@lsp.type.decorator"]     = { fg = PURPLE },
        ["@lsp.type.variable"]      = { fg = WHITE },
        ["@lsp.type.property"]      = { fg = WHITE },
        ["@lsp.type.event"]         = { fg = WHITE },
        ["@lsp.type.parameter"]     = { fg = ORANGE },
        ["@lsp.type.enumMember"]    = { fg = BLUE },
        ["@lsp.type.number"]        = { fg = BLUE },
        ["@lsp.type.regexp"]        = { fg = BLUE },
        ["@lsp.type.string"]        = { fg = "#9ecbff" },
        ["@lsp.type.comment"]       = { fg = "#6a737d" },
        ["@lsp.type.keyword"]       = { fg = RED },
        ["@lsp.type.operator"]      = { fg = RED },
        ["@lsp.typemod.variable.readonly"]         = { fg = BLUE },
        ["@lsp.typemod.property.readonly"]         = { fg = BLUE },
        ["@lsp.typemod.variable.defaultLibrary"]   = { fg = BLUE },
        ["@lsp.typemod.property.defaultLibrary"]   = { fg = BLUE },
        -- Callables stay purple even from the default library, as in Cursor (.map, console.error).
        ["@lsp.typemod.function.defaultLibrary"]   = { fg = PURPLE },
        ["@lsp.typemod.method.defaultLibrary"]     = { fg = PURPLE },
        ["@lsp.typemod.member.defaultLibrary"]     = { fg = PURPLE },
        ["@lsp.typemod.class.defaultLibrary"]      = { fg = BLUE },
        ["@lsp.typemod.type.defaultLibrary"]       = { fg = BLUE },
        ["@lsp.typemod.interface.defaultLibrary"]  = { fg = BLUE },

        -- Ground truth from running VS Code's tokenizer (vscode-textmate +
        -- Cursor's JS grammar) against dark.json:
        ["@string.escape"]                  = { fg = BLUE }, -- \n in strings
        ["@string.regexp.delimiter"]        = { fg = "#9ecbff" }, -- the / /
        ["@character.special.javascript"]   = { fg = RED }, -- regex flags g,i
        ["@character.special.typescript"]   = { fg = RED },
        ["@character.special.tsx"]          = { fg = RED },
        ["@operator.regex"]                 = { fg = RED }, -- + * ? |
        ["@punctuation.delimiter.regex"]    = { fg = RED }, -- ^ $
        ["@punctuation.bracket.regex"]      = { fg = "#dbedff" }, -- group ( )
        ["@constant.regex"]                 = { fg = BLUE }, -- chars in [..]
        ["@string.escape.regex"]            = { fg = BLUE }, -- \d \s \b
        ["@constant.character.escape.regex"] = { fg = "#85e89d" }, -- \[ \] \.
        ["@number.regex"]                   = { fg = RED }, -- {2,3}
        ["@variable.builtin.regex"]         = { fg = BLUE }, -- .

        -- Destructuring source keys: `const { a: b }` renders `a` orange.
        ["@ghkey"] = { fg = ORANGE },

        -- try/catch/throw/finally are plain keywords in GitHub Dark
        ["@keyword.exception"] = { fg = RED },

        -- JSDoc: VS Code renders @tag red, the whole {type} purple, names white
        ["@type.jsdoc"]                = { fg = PURPLE },
        ["@punctuation.bracket.jsdoc"] = { fg = PURPLE },
        ["@punctuation.delimiter.jsdoc"] = { fg = WHITE },
        ["@variable.jsdoc"]            = { fg = WHITE },
        ["@variable.parameter.jsdoc"]  = { fg = WHITE },
        ["@property.jsdoc"]            = { fg = WHITE },
        ["@function.jsdoc"]            = { fg = WHITE },
        ["@keyword.jsdoc"]             = { fg = RED },

        -- Bracket-pair colors (editorBracketHighlight.foreground1-6)
        RainbowGH1 = { fg = BLUE },
        RainbowGH2 = { fg = ORANGE },
        RainbowGH3 = { fg = PURPLE },

        WinBar   = { fg = "#1f2428", bg = "#477fbf", bold = true },
        WinBarNC = { fg = WHITE, bg = "#1f2428" },
      },
    },
  })
  vim.cmd("colorscheme github_dark")
end

return M
