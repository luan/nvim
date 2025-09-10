-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.relativenumber = false

vim.g.snacks_animate = false

vim.opt.mousemoveevent = true

-- Clipboard configuration
vim.opt.clipboard = "unnamedplus"

-- Window splitting behavior
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below

-- HACK: this semantic token is overriding the custom sql injection highlight
vim.api.nvim_set_hl(0, "@lsp.type.string.rust", {})
vim.api.nvim_set_hl(0, "@lsp.type.string.swift", {})

vim.g.lazyvim_rust_diagnostics = "bacon-ls"
