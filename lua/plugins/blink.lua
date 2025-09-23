return {
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },

    opts = {
      sources = {
        providers = {
          copilot = {
            module = "blink-copilot",
          },
        },
      },
      keymap = {
        preset = "enter",
        ["<C-f>"] = false,
        ["<C-y>"] = { "select_and_accept" },
        ["<M-;>"] = { "select_and_accept" },
      },
    },
  },
}
