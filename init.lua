-- Disable some in built plugins completely
vim.g.loaded_netrwPlugin      = 1
vim.g.loaded_2html_plugin     = 1
vim.g.loaded_getscriptPlugin  = 1
vim.g.loaded_logipat          = 1
vim.g.loaded_rrhelper         = 1
vim.g.loaded_vimballPlugin    = 1

require('globals')
require('packer-init')

local has_module  = require('utils').has_module
local file_exists = require('utils').file_exists
local copy = require('utils').copy

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
