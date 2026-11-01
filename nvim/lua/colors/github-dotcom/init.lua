-- github.com's code colors on the editor's own backgrounds. Colors come from GitHub's
-- dark theme CSS; groups and queries/ map its prettylights classes onto nvim's highlights.
local M = {}

local WHITE, BLUE, ORANGE, PURPLE, RED, GREY, STRING = "#f0f6fc", "#79c0ff", "#ffa657", "#d2a8ff", "#ff7b72", "#9198a1", "#a5d6ff"

function M.apply()
  require("github-theme").reset()
  require("github-theme").setup({
    specs = {
      github_dark_default = {
        bg0 = "#1f2428", bg1 = "#24292e", bg2 = "#2b3036", bg3 = "#2f363d", bg4 = "#444d56",
        fg1 = WHITE, fg2 = "#959da5", fg3 = "#444d56",
        sel0 = "#284566", sel1 = "#2b3036", sel2 = "#5e5632",
        syntax = { comment = GREY, variable = WHITE, ident = WHITE, bracket = WHITE, field = BLUE },
      },
    },
    groups = {
      github_dark_default = {
        WinBar   = { fg = "#1f2428", bg = "#477fbf", bold = true },
        WinBarNC = { fg = "#e1e4e8", bg = "#1f2428" },
        envField = { fg = ORANGE }, -- .env keys

        -- pl-smi: types are plain text; pl-v: capitalised values are orange.
        ["@type"] = { fg = WHITE },
        ["@type.builtin"] = { fg = WHITE },
        ["@type.definition"] = { fg = WHITE },
        ["@lsp.type.interface"] = { fg = WHITE },
        ["@lsp.type.type"] = { fg = WHITE },
        ["@lsp.type.typeParameter"] = { fg = WHITE },
        ["@lsp.type.enum"] = { fg = WHITE },
        ["@constructor"] = { fg = ORANGE },

        -- pl-s1: plain identifiers. GitHub colors by how a name is used, so the LSP's
        -- "this is a function/class" tokens get no color and treesitter's rules win.
        ["@variable"] = { fg = WHITE },
        ["@variable.builtin"] = { fg = WHITE },
        ["@variable.parameter"] = { fg = WHITE },
        ["@module.builtin"] = { fg = WHITE },
        ["@lsp.type.class"] = {},
        ["@lsp.type.function"] = {},
        ["@lsp.type.method"] = {},
        ["@lsp.typemod.function.defaultLibrary"] = {},
        ["@lsp.typemod.method.defaultLibrary"] = {},
        ["@lsp.typemod.variable.defaultLibrary"] = {},

        -- pl-c1: properties and operators; pl-k: every keyword.
        ["@variable.member"] = { fg = BLUE },
        ["@property"] = { fg = BLUE },
        ["@operator"] = { fg = BLUE },
        ["@keyword.exception"] = { fg = RED },
        ["@keyword.conditional.ternary"] = { fg = WHITE },
        ["@punctuation.bracket.regex"] = { fg = STRING },
        ["@keyword.directive.javascript"] = { fg = STRING }, -- 'use strict'
        ["@keyword.directive.typescript"] = { fg = STRING },
        ["@keyword.directive.tsx"] = { fg = STRING },

        -- Doc comments stay comment-colored apart from the @tag and {type}.
        ["@type.jsdoc"] = { fg = WHITE },
        ["@variable.jsdoc"] = { fg = GREY },
        ["@variable.parameter.jsdoc"] = { fg = GREY },
        ["@variable.member.jsdoc"] = { fg = GREY },
        ["@property.jsdoc"] = { fg = GREY },
        ["@function.jsdoc"] = { fg = GREY },
        ["@punctuation.bracket.jsdoc"] = { fg = GREY },
        ["@punctuation.delimiter.jsdoc"] = { fg = GREY },
        ["@punctuation.special.jsdoc"] = { fg = GREY },

        -- Python differs: attributes, method calls and and/or/not are blue, calls purple.
        ["@variable.member.python"] = { fg = BLUE },
        ["@variable.builtin.python"] = { fg = WHITE },
        ["@type.builtin.python"] = { fg = WHITE },
        ["@type.python"] = { fg = ORANGE },
        ["@constructor.python"] = { fg = PURPLE },
        ["@function.method.call.python"] = { fg = BLUE },
        ["@keyword.operator.python"] = { fg = BLUE },
        ["@attribute.python"] = { fg = PURPLE },
        ["@attribute.builtin.python"] = { fg = PURPLE },

        -- SQL: GitHub's simpler grammar makes types and operators keywords, the rest plain.
        ["@type.builtin.sql"] = { fg = RED },
        ["@operator.sql"] = { fg = RED },
        ["@constant.sql"] = { fg = BLUE },
        ["@type.sql"] = { fg = WHITE },
        ["@variable.sql"] = { fg = WHITE },
        ["@variable.member.sql"] = { fg = WHITE },
        ["@attribute.sql"] = { fg = WHITE },
        ["@keyword.modifier.sql"] = { fg = WHITE },
        ["@function.call.sql"] = { fg = WHITE },

        -- JSX: lowercase tags are plain.
        ["@tag.builtin.tsx"] = { fg = WHITE },
        ["@tag.builtin.javascript"] = { fg = WHITE },
      },
    },
  })
  vim.cmd("colorscheme github_dark_default")
end

return M
