return {
  {
    "rcarriga/nvim-notify",
    commit = "7caeaaef257ecbe95473ec79e5a82757b544f1fd",
    config = function()
      require("config.notify")
    end,
  },

  {
    "loctvl842/neo-tree.nvim",
    config = function()
      require("config.neo-tree")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("config.bufferline")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "loctvl842/monokai-pro.nvim" },
    config = function()
      require("config.lualine")
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    commit = "8f2e78d0256eba4896c8514aa150e41e63f7d5b2",
    config = function()
      require("config.toggleterm")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("config.indent-blankline")
    end,
  },

  {
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha")
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("config.nvim-web-devicons")
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("config.scrollbar")
    end,
  },

  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
      "loctvl842/monokai-pro.nvim",
    },
    config = function()
      require("config.barbecue")
    end,
  },
}
