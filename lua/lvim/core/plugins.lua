local c = require("lvim.utils.plugins").c
local d = require("lvim.utils.plugins").d
local p = require("lvim.utils.plugins").p
local l = require("lvim.utils.plugins").l

local groups = {
  libs = p(100) {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "dstein64/vim-startuptime",
    "Tastyep/structlog.nvim",
    c "folke/neodev.nvim",
  },

  colorschemes = l(p(1000) {
    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    "rafamadriz/neon",
    "sainnhe/sonokai",
    "loctvl842/monokai-pro.nvim",
  }),

  ui = {
    c "rcarriga/nvim-notify",
    c { "nvim-tree/nvim-tree.lua", tag = "nightly" },
    c { "tamago324/lir.nvim", dependencies = { "tamago324/lir-git-status.nvim" } },
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
    d "karb94/neoscroll.nvim",
    { "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
    c {
      "utilyre/barbecue.nvim",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
        "loctvl842/monokai-pro.nvim",
      },
    },
    c "folke/noice.nvim",
    d "petertriho/nvim-scrollbar",
    d "mawkler/modicator.nvim",
  },

  utilities = {
    {
      -- TODO: replace with 0.9.0 feature
      "jghauser/mkdir.nvim",
      config = function()
        require "mkdir"
      end,
    },
    c "stevearc/overseer.nvim",
    c {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-go",
        "haydenmeade/neotest-jest",
        "marilari88/neotest-vitest",
        "rouge8/neotest-rust",
        "nvim-neotest/neotest-vim-test",
        "vim-test/vim-test",
      },
    },
    c "stevearc/resession.nvim",
    "chrisgrieser/nvim-genghis",
    d "chrisgrieser/nvim-recorder",
    c "Wansmer/treesj",
  },

  finding = {
    c "ibhagwan/fzf-lua",
    c "nvim-telescope/telescope.nvim",
    { "nvim-telescope/telescope-frecency.nvim", dependencies = "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    "nvim-telescope/telescope-ui-select.nvim",
  },

  editor = {
    c {
      "mrjones2014/legendary.nvim",
      opts = { which_key = { auto_register = true } },
      lazy = false,
      priority = 10,
    },
    "folke/which-key.nvim",

    c "ahmedkhalf/project.nvim",
    c {
      "tanvirtin/vgit.nvim",
      event = "BufReadPre",
    },
    -- TODO: check for lua version
    c "RRethy/vim-illuminate",
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
    c {
      "numToStr/Comment.nvim",
      dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    },
    -- TODO: check for lua version
    "mg979/vim-visual-multi",
    c { "kevinhwang91/nvim-bqf", dependencies = { "junegunn/fzf" } },
    c "windwp/nvim-spectre",
    "cshuaimin/ssr.nvim",

    d "abecodes/tabout.nvim",
    d "phaazon/hop.nvim",

    d "kylechui/nvim-surround",
    c "code-biscuits/nvim-biscuits",
    d "nguyenvukhang/nvim-toggler",

    c "gbprod/cutlass.nvim",
    c "gbprod/yanky.nvim",
    c "gbprod/substitute.nvim",
  },

  code = {
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
    },

    {
      event = "InsertEnter",
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    c {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "mfussenegger/nvim-jdtls",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
      },
    },
    "lvimuser/lsp-inlayhints.nvim",
    c "ray-x/lsp_signature.nvim",
    c {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/playground",
        "mrjones2014/nvim-ts-rainbow",
        "RRethy/nvim-treesitter-endwise",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "m-demare/hlargs.nvim",
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
      "zbirenbaum/copilot.lua",
      enabled = lvim.copilot.enabled,
      name = "copilot",
      event = "InsertEnter",
      cmd = "Copilot",
    },
    c {
      "Exafunction/codeium.vim",
      enabled = lvim.codeium.enabled and not lvim.copilot.enabled,
      event = "InsertEnter",
      cmd = "Codeium",
    },
  },

  -- TODO: check for lua version
  tpope = {
    "tpope/vim-abolish",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-rhubarb",
    "tpope/vim-unimpaired",
  },

  user = lvim.plugins,
}

local all_plugins = {}
for _, group in pairs(groups) do
  for _, v in pairs(group) do
    table.insert(all_plugins, v)
  end
end

return all_plugins
