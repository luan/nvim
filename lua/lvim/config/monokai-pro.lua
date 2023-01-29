local monokai = require "monokai-pro"
monokai.setup {
  transparent_background = true,
  italic_comments = true,
  filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
  inc_search = "underline", -- underline | background
  background_clear = {},
  diagnostic = {
    background = true,
  },
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
    },
    indent_blankline = {
      context_highlight = "pro", -- default | pro
    },
    lualine = {
      float = true,
      colorful = true,
    },
  },
}

monokai.load()
vim.api.nvim_command "hi IndentBlanklineContextStart gui=underdotted"
