return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			require("lvim.config.lsp")
		end,
	},

	-- cmdline tools and language servers manager (e.g. pyright)
	{
		"williamboman/mason.nvim",
		config = function()
			require("lvim.config.mason")
		end,
	},

	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		config = function()
			require("lvim.config.null-ls")
		end,
	},

	"mfussenegger/nvim-jdtls",
}
