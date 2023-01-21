if os.getenv('TMUX') ~= '' then
  vim.g['test#strategy'] = 'vimux'
  vim.g['test#preserve_screen'] = 0
end

require("neotest").setup({
  adapters = {
    require('neotest-go'),
    require("neotest-vim-test")({ ignore_filetypes = { "go" } }),
  }
})
