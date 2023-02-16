local util = require "lvim.utils.colors"

require("catppuccin").setup {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  show_end_of_buffer = true, -- show the '~' characters after the end of buffers
  term_colors = false,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  custom_highlights = function(c)
    local dark = c.surface0
    return {
      CmpItemKindSnippet = { fg = c.base, bg = c.mauve },
      CmpItemKindKeyword = { fg = c.base, bg = c.red },
      CmpItemKindText = { fg = c.base, bg = c.teal },
      CmpItemKindMethod = { fg = c.base, bg = c.blue },
      CmpItemKindConstructor = { fg = c.base, bg = c.blue },
      CmpItemKindFunction = { fg = c.base, bg = c.blue },
      CmpItemKindFolder = { fg = c.base, bg = c.blue },
      CmpItemKindModule = { fg = c.base, bg = c.blue },
      CmpItemKindConstant = { fg = c.base, bg = c.peach },
      CmpItemKindField = { fg = c.base, bg = c.green },
      CmpItemKindProperty = { fg = c.base, bg = c.green },
      CmpItemKindEnum = { fg = c.base, bg = c.green },
      CmpItemKindUnit = { fg = c.base, bg = c.green },
      CmpItemKindClass = { fg = c.base, bg = c.yellow },
      CmpItemKindVariable = { fg = c.base, bg = c.flamingo },
      CmpItemKindFile = { fg = c.base, bg = c.blue },
      CmpItemKindInterface = { fg = c.base, bg = c.yellow },
      CmpItemKindColor = { fg = c.base, bg = c.red },
      CmpItemKindReference = { fg = c.base, bg = c.red },
      CmpItemKindEnumMember = { fg = c.base, bg = c.red },
      CmpItemKindStruct = { fg = c.base, bg = c.blue },
      CmpItemKindValue = { fg = c.base, bg = c.peach },
      CmpItemKindEvent = { fg = c.base, bg = c.blue },
      CmpItemKindOperator = { fg = c.base, bg = c.blue },
      CmpItemKindTypeParameter = { fg = c.base, bg = c.blue },
      CmpItemKindCopilot = { fg = c.base, bg = c.teal },
      TelescopeNormal = { bg = dark, fg = c.fg_dark },
      TelescopeBorder = { bg = dark, fg = dark },
      TelescopePromptNormal = { bg = dark },
      TelescopePromptBorder = { bg = dark, fg = dark },
      TelescopePromptTitle = { bg = dark, fg = dark },
      TelescopePreviewTitle = { bg = dark, fg = dark },
      TelescopeResultsTitle = { bg = dark, fg = c.bg_dark },
      NoiceCursor = { bg = c.yellow },
      IndentBlanklineContextChar = { fg = util.darken(c.flamingo, 0.3) },
      IndentBlanklineContextStart = { sp = util.darken(c.flamingo, 0.3) },
    }
  end,
  color_overrides = {},
  integrations = {
    barbar = true,
    cmp = true,
    dashboard = true,
    gitsigns = true,
    hop = true,
    illuminate = true,
    lsp_trouble = true,
    markdown = true,
    mason = true,
    neotest = true,
    neotree = true,
    noice = true,
    notify = true,
    overseer = true,
    semantic_tokens = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    which_key = true,

    -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
    barbecue = {
      dim_dirname = true,
    },
    indent_blankline = {
      enabled = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "underdashed" },
        warnings = { "undercurl" },
        information = { "underdashed" },
      },
    },
    navic = {
      enabled = true,
    },
  },
}

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
