return {
  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false },

  {
    "klen/nvim-config-local",
    config = function()
      require("config-local").setup({
        silent = true, -- Disable plugin messages (Config loaded/denied)
      })
    end,
  },

  { "tpope/vim-abolish" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-sleuth" },
  { "wsdjeg/vim-fetch" },
}
