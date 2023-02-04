---@diagnostic disable: param-type-mismatch
vim.defer_fn(function()
  require("copilot").setup {
    suggestion = {
      enabled = false,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        next = "<M-n>",
        prev = "<M-p>",
        dismiss = "<C-k>",
      },
    },
    panel = { enabled = false },
  }
end, 100)
