-- -- vim options
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2
-- vim.opt.relativenumber = true

-- -- general
-- lvim.log.level = "info"

-- --  Additional Plugins
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- --  Additional LSP setup
-- require("lvim.lsp").setup("emmet_ls", { filetuypes = { "handlebars" } })

-- -- ␀ null-ls sources <https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md>
-- -- Note that you have to install the tool with Mason manually
-- lvim.nullls.sources = {
-- 	require("null-ls").builtins.formatting.stylua,
-- 	require("null-ls").builtins.formatting.goimports,
-- 	require("null-ls").builtins.formatting.google_java_format,
-- 	require("null-ls").builtins.formatting.sqlfluff.with({
-- 		extra_args = { "--dialect", "postgres" },
-- 	}),
-- }

-- --  Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
