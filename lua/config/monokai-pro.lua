local monokai = require("monokai-pro")
monokai.setup({
  transparent_background = true,
  italic_comments = true,
  filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
  inc_search = "background", -- underline | background
  background_clear = {},
  diagnostic = {
    background = true,
  },
  plugins = {
    bufferline = {
      underline_selected = true,
      underline_visible = false,
    },
    indent_blankline = {
      context_highlight = "pro", -- default | pro
    },
  },
})
monokai.load()

