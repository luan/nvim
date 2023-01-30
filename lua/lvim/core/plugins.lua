local function config(opts)
  local name = string.lower(opts.name:gsub("%..*", ""))
  name = name:gsub("^n?vim%-", ""):gsub("%-n?vim$", ""):gsub("_", "-"):gsub("lspconfig", "lsp")
  local mod = "lvim.config." .. name
  local m = require(mod)
  if type(m) == "table" then
    m.setup()
  end
end

local function tableize(spec)
  if type(spec) == "string" then
    spec = { spec }
  end
  return spec
end

local function c(spec)
  spec = tableize(spec)
  spec["config"] = config
  return spec
end

local groups = {
  libs = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "dstein64/vim-startuptime",
    "Tastyep/structlog.nvim",
  },

  colorschemes = {
    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    "sainnhe/gruvbox-material",
    c {
      "loctvl842/monokai-pro.nvim",
      lazy = false,
      priority = 1000,
    },
  },

  ui = {
    c "rcarriga/nvim-notify",
    c "nvim-neo-tree/neo-tree.nvim",
    c {
      "nvim-lualine/lualine.nvim",
      dependencies = { "loctvl842/monokai-pro.nvim" },
    },
    c "akinsho/toggleterm.nvim",
    c {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
    },
    c "goolord/alpha-nvim",
    c "nvim-tree/nvim-web-devicons",
    { "karb94/neoscroll.nvim", config = true },
    { "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
    c {
      "utilyre/barbecue.nvim",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
        "loctvl842/monokai-pro.nvim",
      },
    },
  },

  files = {
    {
      "jghauser/mkdir.nvim",
      config = function()
        require "mkdir"
      end,
    },
  },

  editor = {
    c "ahmedkhalf/project.nvim",
    c {
      "nvim-telescope/telescope.nvim",
      dependencies = { "telescope-fzf-native.nvim" },
    },
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-frecency.nvim", dependencies = "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    c "folke/which-key.nvim",
    c {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
    },
    c "RRethy/vim-illuminate",
    "moll/vim-bbye",
    c {
      "kevinhwang91/nvim-ufo",
      dependencies = "kevinhwang91/promise-async",
    },
    c {
      "kosayoda/nvim-lightbulb",
      dependencies = "antoinemadec/FixCursorHold.nvim",
    },
    c {
      "windwp/nvim-autopairs",
      event = "VeryLazy",
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
    c {
      "numToStr/Comment.nvim",
      dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    },
    "mg979/vim-visual-multi",
    c "kevinhwang91/nvim-bqf",
    c "windwp/nvim-spectre",
    "cshuaimin/ssr.nvim",

    "junegunn/vim-easy-align",
    { "abecodes/tabout.nvim", config = true },
    "machakann/vim-swap",
    { "phaazon/hop.nvim", config = true },
    "mbbill/undotree",
    "romainl/vim-qf",
    "tommcdo/vim-exchange",
  },

  code = {
    "L3MON4D3/LuaSnip",

    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    c {
      "hrsh7th/nvim-cmp",
      commit = "0e436ee23abc6c3fe5f3600145d2a413703e7272",
      event = "InsertEnter",
      dependencies = {
        "mfussenegger/nvim-jdtls",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
      },
    },
    c "filipdutescu/renamer.nvim",
    "lvimuser/lsp-inlayhints.nvim",

    c "ray-x/lsp_signature.nvim",

    c {
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/playground",
        "mrjones2014/nvim-ts-rainbow",
        "RRethy/nvim-treesitter-endwise",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },

    c {
      "neovim/nvim-lspconfig",
      branch = "master",
      event = "BufReadPre",
    },

    c {
      "williamboman/mason.nvim",
      dependencies = { "williamboman/mason-lspconfig.nvim" },
    },

    c {
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufReadPre",
    },
    c {
      "zbirenbaum/copilot-cmp",
      name = "copilot",
      event = "InsertEnter",
      cmd = "Copilot",
      dependencies = { "zbirenbaum/copilot.lua" },
    },
  },

  tpope = {
    "tpope/vim-abolish",
    "tpope/vim-eunuch",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-rhubarb",
    "tpope/vim-sleuth",
    "tpope/vim-surround",
  },
}

local all_plugins = {}
for _, group in pairs(groups) do
  for _, v in pairs(group) do
    table.insert(all_plugins, v)
  end
end

return all_plugins
