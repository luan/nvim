local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end
local devicons = require "nvim-web-devicons"
local lualine_require = require "lualine_require"
local modules = lualine_require.lazy_require {
  highlight = "lualine.highlight",
  utils = "lualine.utils.utils",
}

local separator = "bubble" -- bubble | triangle
local separator_icon = {
  left = "",
  right = "",
}

local alt_separator_icon = {
  left = "",
  right = "",
}

if separator == "triangle" then
  separator_icon = {
    left = "",
    right = "",
  }

  alt_separator_icon = {
    left = "",
    right = "",
  }
end

local branch = {
  "branch",
  icon = { "", color = { fg = "green" } },
}

local location = {
  "location",
  fmt = function(str)
    return "" .. str
  end,
}

local diagnostics = {
  "diagnostics",
  colored = true,
  update_in_insert = true,
  always_visible = true,
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

local mode = {
  "mode",
  icons_enabled = true,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  colored = true,
  icons_only = false,
}

local float_config = {
  options = {
    -- theme = "monokai-pro",
    icons_enabled = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = { "neo-tree" },
      "alpha",
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = { mode, branch },
    lualine_b = { diagnostics },
    lualine_c = {},
    lualine_x = { diff },
    lualine_y = { location, filetype },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

lualine.setup(float_config)
