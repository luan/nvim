local opt         = vim.opt
local g           = vim.g

-- General
opt.autoread      = true                   -- reload changes from disk
opt.autowriteall  = true                   -- Writes on make/shell commands
opt.hidden        = true                   -- Allow buffer switching without saving
opt.linespace     = 0                      -- No extra spaces between rows
opt.wrap          = false                   -- Do not wrap long lines
opt.number        = true                   -- Show line numbers
opt.scrolloff     = 5                      -- Minumum lines to keep above and below cursor
opt.showmatch     = true                   -- Show matching brackets/parentthesis
opt.splitright    = true                   -- Vertical splits to the right
opt.termguicolors = true                   -- Enable true colors in terminal
opt.updatetime    = 100                    -- Update swap file and CursorHold delay
opt.timeoutlen    = 700                    -- Timeout for keybindings
opt.ttimeoutlen   = 0                      -- Timeout for completing commands
opt.inccommand    = 'nosplit'              -- Preview commands like substitute
opt.iskeyword:append('$', '@', '-')
opt.wildmode      = {'list', 'longest'}    -- Use emacs-style tab completion in command mode

opt.ignorecase    = true                   -- Case insensitive search
opt.smartcase     = true                   -- ... but case sensitive when uc present

opt.sessionoptions = {'blank', 'buffers', 'curdir', 'folds', 'help', 'options', 'tabpages', 'winsize', 'resize', 'winpos', 'terminal'}

-- Mouse
opt.mouse         = 'a'                    -- Mouse enabled in all modes

-- Completion
opt.pumheight     = 20                     -- Avoid the pop up menu occupying the whole screen
opt.completeopt   = {'noinsert', 'menuone', 'noselect'}
opt.shortmess:append('c')                  -- don't pass messages to |ins-completion-menu|

-- Indentation
opt.expandtab     = true                   -- Tabs are spaces, not tabs
opt.shiftwidth    = 4                      -- Use indents of 2 spaces
opt.softtabstop   = 4                      -- Let backspace delete indent
opt.tabstop       = 4                      -- An indentation every four columns

-- Undo
opt.undofile      = true                   -- Persistent undo
opt.undodir       = CACHE_PATH .. '/undo'  -- set an undo directory
opt.undolevels    = 1000                   -- Maximum number of changes that can be undone
opt.undoreload    = 10000                  -- Maximum number lines to save for undo on a buffer reload

-- Command mode
opt.showmode      = false                  -- Hide current mode in command-line (shown by lightline)
opt.fillchars = 'vert:│,stl: ,stlnc: '

-- Encoding & file formats
opt.fileencoding  = 'utf-8'

-- Backups
opt.writebackup   = false

-- Cursor line
opt.cursorline    = true

-- Folding
opt.foldlevel    = 20
opt.foldmethod   = 'expr'
opt.foldexpr     = 'nvim_treesitter#foldexpr()'

g.do_filetype_lua = 1 -- use filetype.lua
g.did_load_filetypes = 0 -- don't use filetype.vim

vim.cmd [[
augroup config#basic
  autocmd!
  " Don't format when adding lines with o/O
  autocmd BufNewFile,BufEnter * set formatoptions-=o

  " Reload file on focus
  autocmd FocusGained * :checktime
augroup END
]]
