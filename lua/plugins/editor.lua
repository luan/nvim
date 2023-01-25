return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope")
    end,
  },

  {
    "folke/which-key.nvim",
    init = function()
      require("config.which-key")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("config.gitsigns")
    end,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("config.illuminate")
    end,
  },

  "moll/vim-bbye",

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("config.project")
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("config.ufo")
    end,
  },

  {
    "kosayoda/nvim-lightbulb",
    dependencies = { "antoinemadec/FixCursorHold.nvim" },
    config = function()
      require("config.lightbulb")
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      require("config.autopairs")
    end,
  },

  {
    "j-hui/fidget.nvim",
    config = {
      window = {
        relative = "win", -- where to anchor, either "win" or "editor"
        blend = 50, -- &winblend for the window
        zindex = nil, -- the zindex value for the window
        border = "none", -- style of border for the fidget window
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("config.comment")
    end,
  },

  {
    "kevinhwang91/rnvimr",
    config = function()
      require("config.rnvimr")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("config.colorizer")
    end,
  },

  "mg979/vim-visual-multi",
  'jghauser/mkdir.nvim',
  'kevinhwang91/nvim-bqf',
  'windwp/nvim-spectre',
  'sindrets/diffview.nvim',
}
