require("noice").setup {
  presets = {
    long_message_to_split = true,
  },
  routes = {
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
    {
      view = "notify",
      filter = {
        find = "no matching language servers",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },
  lsp = {
    hover = {
      enabled = false,
    },
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
