CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

local g = vim.g

g.mapleader = " "
g.auto_save = false
g.vsnip_snippet_dirs = {CONFIG_PATH .. '/snippets'}
