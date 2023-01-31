vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = "?*",
  callback = function()
    vim.api.nvim_command "hi IndentBlanklineContextStart gui=underdotted"
  end,
})

vim.cmd.colorscheme { args = { "monokai-pro" } }
