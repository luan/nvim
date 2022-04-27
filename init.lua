-- Disable some in built plugins completely
vim.g.loaded_netrwPlugin      = 1
vim.g.loaded_2html_plugin     = 1
vim.g.loaded_getscriptPlugin  = 1
vim.g.loaded_logipat          = 1
vim.g.loaded_rrhelper         = 1
vim.g.loaded_vimballPlugin    = 1

if vim.version().major == 0 and vim.version().minor < 7 then
    local fmt = string.format
    local version = vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
    vim.api.nvim_err_writeln(
        fmt('luan/nvim requires at least nvim-0.7.0 (current %s)', version)
    )
    vim.api.nvim_err_writeln('Please update Neovim')
    return
end

require('globals')
require('packer-init')

local has_module  = require('utils').has_module

if has_module('user.before') then
    require('user.before')
end

local modules = {
    'settings',
    'plugins',
    'colorscheme',
    'keyboard',
    'diagnostics',
    'paste',
    'lang',
}

for i = 1, #modules, 1 do
    pcall(require, modules[i])
end

if has_module('user.after') then
    require('user.after')
end

require('update')
