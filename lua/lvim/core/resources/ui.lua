return {
  {
    "rcarriga/nvim-notify",
    commit = "7caeaaef257ecbe95473ec79e5a82757b544f1fd",
    config = function()
      require("lvim.config.notify")
    end,
  },

  {
    "loclvim842/neo-tree.nvim",
    config = function()
      require("lvim.config.neo-tree")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("lvim.config.bufferline")
    end,
  },

  -- {
  --   "loclvim842/breadcrumb.nvim",
  --   init = function()
  --     require("lvim.config.breadcrumb")
  --   end,
  -- },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "loclvim842/monokai-pro.nvim" },
    config = function()
      require("lvim.config.lualine")
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    commit = "8f2e78d0256eba4896c8514aa150e41e63f7d5b2",
    config = function()
      require("lvim.config.toggleterm")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("lvim.config.indent-blankline")
    end,
  },

  {
    "goolord/alpha-nvim",
    config = function()
      require("lvim.config.alpha")
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("lvim.config.nvim-web-devicons")
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("lvim.config.scrollbar")
    end,
  },

  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
      "loclvim842/monokai-pro.nvim",
    },
    config = function()
      require("lvim.config.barbecue")
    end,
  },
}
