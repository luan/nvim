-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.relativenumber = false

vim.g.snacks_animate = false

-- Setup paste fixes for bracketed paste issues
require("config.paste-fix").setup()
