local options = {
   autoread = true, -- reload changes from disk
   autowriteall = true, -- Writes on make/shell commands
   hidden = true, -- Allow buffer switching without saving
   linespace = -1, -- No extra spaces between rows
   wrap = false, -- Do not wrap long lines
   number = true, -- Show line numbers
   scrolloff = 4, -- Minumum lines to keep above and below cursor
   showmatch = true, -- Show matching brackets/parentthesis
   splitright = true, -- Vertical splits to the right
   termguicolors = true, -- Enable true colors in terminal
   updatetime = 300, -- Update swap file and CursorHold delay
   signcolumn = "yes", -- Always enable sign column to avoid spasms
   timeoutlen = 500, -- Timeout for keybindings
   ttimeoutlen = -1, -- Timeout for completing commands
   inccommand = "nosplit", -- Preview commands like substitute
   wildmode = { "list", "longest" }, -- Use emacs-style tab completion in command mode

   ignorecase = true, -- Case insensitive search
   smartcase = true, -- ... but case sensitive when uc present

   sessionoptions = {
      "blank",
      "buffers",
      "curdir",
      "folds",
      "help",
      "options",
      "tabpages",
      "winsize",
      "resize",
      "winpos",
      "terminal",
   },

   -- Mouse
   mouse = "a", -- Mouse enabled in all modes

   -- Completion
   pumheight = 20, -- Avoid the pop up menu occupying the whole screen
   completeopt = { "menuone", "noselect" },

   -- Indentation
   expandtab = true, -- Tabs are spaces, not tabs
   shiftwidth = 3, -- Use indents of 2 spaces
   softtabstop = 3, -- Let backspace delete indent
   tabstop = 3, -- An indentation every four columns

   -- Undo
   undofile = true, -- Persistent undo
   undodir = CACHE_PATH .. "/undo", -- set an undo directory
   undolevels = 999, -- Maximum number of changes that can be undone
   undoreload = 9999, -- Maximum number lines to save for undo on a buffer reload
   showmode = false, -- Hide current mode in command-line
   fillchars = "vert:│,stl: ,stlnc: ",

   writebackup = false,
   cursorline = true,
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shortmess:append "c"
vim.opt.iskeyword:append("$", "@", "-")

for k, v in pairs(options) do
   vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,]"
vim.cmd [[set iskeyword+=-]]
-- diable open fold with `l`
vim.cmd [[set foldopen-=hor]]
