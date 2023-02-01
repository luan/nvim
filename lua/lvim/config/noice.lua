require("noice").setup {
  messages = {
    enabled = false,
  },
  lsp = {
    signature = {
      enabled = false,
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = 12,
        col = "50%",
      },

      border = {
        style = "none",
        padding = { 1, 2 },
      },
      filter_options = {},
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 15,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "none",
        padding = { 1, 2 },
      },
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },
}
