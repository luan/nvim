if os.getenv('TMUX') ~= '' then
  vim.g['test#strategy'] = 'vimux'
  vim.g['test#preserve_screen'] = 0
end

local function config()
  require("neotest").setup({
    adapters = {
      require('neotest-go'),
      require("neotest-vim-test")({ ignore_filetypes = { "go" } }),
    }
  })
end

return {
  'nvim-neotest/neotest',
  dependencies = {
    'vim-test/vim-test',
    'nvim-neotest/neotest-vim-test',
    'nvim-neotest/neotest-go',
    'haydenmeade/neotest-jest',
    'mfussenegger/nvim-dap',
  },
  config = config,
}
