require("monokai-pro").setup {
  transparent_background = false,
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
