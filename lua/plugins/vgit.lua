local function config()
  require('vgit').setup {
    keymaps = {
      ['n <C-k>'] = 'hunk_up',
      ['n <C-j>'] = 'hunk_down',
    },
    settings = {
      authorship_code_lens = { enabled = false },
      live_blame = { enabled = false },
    },
  }
end

return {
  'tanvirtin/vgit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = config,
}
