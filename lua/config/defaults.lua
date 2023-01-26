return {
  leader = "space",
  reload_config_on_save = true,
  colorscheme = "monokai-pro",
  format_on_save = {
    ---@usage boolean: format on save (Default: false)
    enabled = false,
    ---@usage pattern string pattern used for the autocommand (Default: '*')
    pattern = "*",
    ---@usage timeout number timeout in ms for the format request (Default: 1000)
    timeout = 1000,
  },
  keys = {},

  use_icons = true,
  icons = require("icons"),

  builtin = {},

  plugins = {
    -- use config.lua for this not put here
  },

  autocommands = {},
  lang = {},
}
