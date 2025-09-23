return {
  "Bekaboo/dropbar.nvim",
  enabled = false,
  -- optional, but required for fuzzy finder support
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  opts = {},
  config = function()
    local dropbar_api = require("dropbar.api")
    vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })

    local dropbar = require("dropbar")
    dropbar.setup({
      icons = {
        ui = {
          bar = {
            separator = "   ",
          },
        },
      },
      menu = {
        scrollbar = {
          background = false,
        },
      },
    })
  end,
}
