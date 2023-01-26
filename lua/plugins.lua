local core = require("core.plugins")
local c = core.c

return {
	-- libs
"nvim-lua/plenary.nvim",
"MunifTanjim/nui.nvim",
"dstein64/vim-startuptime",
"Tastyep/structlog.nvim",

-- ui additions
 c"rcarriga/nvim-notify",
 c"kyazdani42/nvim-tree.lua",
 c{
    "nvim-lualine/lualine.nvim",
    dependencies = { "loctvl842/monokai-pro.nvim" },
  },
   c"akinsho/toggleterm.nvim",
   c{
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
  },
    c{ "goolord/alpha-nvim", name = "alpha" },
    c"nvim-tree/nvim-web-devicons",

    --- colorschemes
      "folke/tokyonight.nvim",
      c"loctvl842/monokai-pro.nvim",

      -- editor features
      c"ahmedkhalf/project.nvim",

      c{
		"neovim/nvim-lspconfig",
		name = "lsp",
		event = "BufReadPre",
	},

		c"williamboman/mason.nvim",

	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
	},
}
