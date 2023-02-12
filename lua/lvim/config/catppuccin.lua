local util = require "tokyonight.util"

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
    local dark = util.darken(c.base, 0.5)
    local hl = {}
    hl.TelescopeNormal = {
      bg = dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = dark,
      fg = dark,
    }
    hl.TelescopePromptNormal = {
      bg = dark,
    }
    hl.TelescopePromptBorder = {
      bg = dark,
      fg = dark,
    }
    hl.TelescopePromptTitle = {
      bg = dark,
      fg = dark,
    }
    hl.TelescopePreviewTitle = {
      bg = dark,
      fg = dark,
    }
    hl.TelescopeResultsTitle = {
      bg = dark,
      fg = c.bg_dark,
    }
    return hl
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
