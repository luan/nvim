return {
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
        ["<Tab>"] = {
          "snippet_forward",
          function() -- sidekick next edit suggestion
            return require("sidekick").nes_jump_or_apply()
          end,
          function() -- if you are using Neovim's native inline completions
            return vim.lsp.inline_completion.get()
          end,
          "fallback",
        },
      },
    },
  },
}
