vim.defer_fn(function()
  -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
  require("copilot").setup()
  -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
  require("copilot_cmp").setup()
end, 100)
