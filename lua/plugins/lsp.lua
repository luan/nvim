return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("config.lsp")
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("config.mason")
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      require("config.null-ls")
    end,
  },
}
