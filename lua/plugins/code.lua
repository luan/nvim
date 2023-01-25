return {
  "L3MON4D3/LuaSnip",

  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end
  },

  {
    "mattn/emmet-vim",
    config = function()
      require("config.emmet")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("config.cmp")
    end,
  },

  {
    "filipdutescu/renamer.nvim",
    branch = "master",
    config = function()
      require("config.renamer")
    end,
  },

  "iamcco/markdown-preview.nvim",

  "lvimuser/lsp-inlayhints.nvim",

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("config.lsp-signature")
    end,
  },

  'cappyzawa/starlark.vim',
  {
    'ray-x/go.nvim',
    config = function()
      require('go').setup({
        lsp_keymaps = false,
      })
      vim.api.nvim_exec([[
                    autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
                ]], false)
    end,
  },
}
