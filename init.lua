local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local spawn = require("lazy.manage.process").spawn
require("lazy.manage.process").spawn = function(cmd, opts)
  opts = opts or {}
  opts.env = vim.list_extend(opts.env or {}, { "GIT_CONFIG_NOSYSTEM=1" })
  return spawn(cmd, opts)
end

-- {{[ GLOBALS
_G.CONFIG_PATH = vim.fn.stdpath('config')
_G.DATA_PATH = vim.fn.stdpath('data')
_G.CACHE_PATH = vim.fn.stdpath('cache')
_G.luanvim = vim.deepcopy(require "config.defaults")
_G.require_clean = require("core.util").require_clean
_G.require_safe = require("core.util").require_safe
_G.reload = require("core.util").reload
_G.get_cache_dir = require("core.util").get_cache_dir
-- }}}

-- {{{ OPTIONS

vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.undodir = CACHE_PATH .. '/undo' -- set an undo directory
vim.o.undolevels = 1000 -- Maximum number of changes that can be undone
vim.o.undoreload = 10000 -- Maximum number lines to save for undo on a buffer reload
vim.o.laststatus = 3
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Transparency for popup-menu
vim.o.pumblend = 10
vim.o.pumheight = 20

-- When jumping to location via quickfix, use buffer in open windows
vim.o.switchbuf = "useopen,uselast"

vim.opt.shortmess:append("c") -- don't pass messages to |ins-completion-menu|
vim.opt.shortmess:append("I") -- Hide the startup screen
vim.opt.shortmess:append("A") -- Ignore swap file messages
vim.opt.shortmess:append("a") -- Shorter message formats
vim.o.showbreak = "↳ "

vim.o.termguicolors = true
vim.o.completeopt = "menuone,noselect"
vim.o.timeoutlen = 500

vim.opt.iskeyword:append('$', '@', '-')

-- Set <space> as the leader key. See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.extra_whitespace_ignored_filetypes = {'alpha'}

-- }}}

require("lazy").setup({
  spec = "plugins",
  defaults = { lazy = false, version = "*" },
  install = { colorscheme = { "monokai-pro" } },
  checker = { enabled = false },
})
