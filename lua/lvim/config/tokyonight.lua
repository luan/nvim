local util = require "tokyonight.util"

require("tokyonight").setup {
  style = "night",
  light_style = "day",
  transparent = false,
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = true, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

  on_highlights = function(hl, c)
    local dark = util.darken(c.bg_dark, 0.5)
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
  end,
}
