vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = "?*",
  callback = function(opts)
    print("colorscheme set", opts)
    vim.api.nvim_command "hi IndentBlanklineContextStart gui=underdotted"
  end,
})

vim.cmd.colorscheme { args = { "monokai-pro" } }
