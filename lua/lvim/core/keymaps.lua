local wk = require "which-key"
local vgit = require "vgit"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local toolbox = require "legendary.toolbox"
require("legendary").keymaps {
  -- Navigate buffers
  { "<S-h>", ":BufferPrevious<CR>", description = "Previous buffer" },
  { "<S-l>", ":BufferNext<CR>", description = "Next buffer" },
  { "<A-S-h>", ":BufferMovePrevious<CR>", description = "Move buffer left" },
  { "<A-S-l>", ":BufferMoveNext<CR>", description = "Move buffer right" },

  -- Go to buffer quickly
  { "<leader>1", "<cmd>BufferGoto  1<CR>", "Go to buffer #1" },
  { "<leader>2", "<cmd>BufferGoto  2<CR>", "Go to buffer #2" },
  { "<leader>3", "<cmd>BufferGoto  3<CR>", "Go to buffer #3" },
  { "<leader>4", "<cmd>BufferGoto  4<CR>", "Go to buffer #4" },
  { "<leader>5", "<cmd>BufferGoto  5<CR>", "Go to buffer #5" },
  { "<leader>6", "<cmd>BufferGoto  6<CR>", "Go to buffer #6" },
  { "<leader>7", "<cmd>BufferGoto  7<CR>", "Go to buffer #7" },
  { "<leader>8", "<cmd>BufferGoto  8<CR>", "Go to buffer #8" },
  { "<leader>9", "<cmd>BufferGoto  9<CR>", "Go to buffer #9" },
  { "<leader>0", "<cmd>BufferGoto 10<CR>", "Go to buffer #10" },

  -- Stay in indent mode
  { "<", "<gv", mode = "x" },
  { ">", ">gv", mode = "x" },

  -- Don't override on paste
  { "p", "dP", mode = "x", opts = { noremap = false } },

  -- Move text up/down
  {
    "<M-j>",
    {
      n = ":m .+1<CR>==",
      v = ":m '>+1<CR>gv=gv",
      i = "<ESC>:m .+1<CR>==gi",
    },
    description = "Move line down",
  },
  {
    "<M-k>",
    {
      n = ":m .-2<CR>==",
      v = ":m '<-2<CR>gv=gv",
      i = "<ESC>:m .-2<CR>==gi",
    },
    description = "Move line up",
  },

  -- No highlight
  { "<esc>", ":noh<cr>", description = "Clear 'hlsearch' highlights" },

  -- Switch two windows
  { "<A-o>", "<C-w>r", description = "Swap 2 windows" },

  -- Search
  { "<M-S-f>", "<cmd>Spectre<cr>", description = "Search in project" },
  { "<M-f>", "<cmd>lua require('spectre').open_file_search()<cr>", description = "Search in file" },
  { "<M-S-s>", "<cmd>lua require('ssr').open()", description = "Structured search & replace" },

  -- Command mode history
  { "<C-k>", "<Up>", mode = "c" },
  { "<C-j>", "<Down>", mode = "c" },

  -- Save
  {
    "<cr>",
    toolbox.lazy(require("lvim.utils").save, { skip_unmodified = true, format = true }),
    description = "Save buffer",
    opts = { expr = true },
  },
  {
    "<M-s>",
    toolbox.lazy(require("lvim.utils").save, { skip_unmodified = false, format = true }),
    description = "Save buffer",
    opts = { expr = true },
  },

  -- Copy to system clipboard
  { "<M-c>", '"+y', description = "Copy to system clipboard", mode = "x" },

  -- Find Files
  { "<C-p>", "<cmd>Telescope find_files<cr>", description = "Find files" },
  { "<M-p>", "<cmd>Telescope find_files<cr>", description = "Find files" },

  -- Global buffer control
  { "<M-w>", "<cmd>BufferClose<cr>", description = "Close buffer" },
  { "<M-W>", "<cmd>close!<cr>", description = "Close window" },
  { "<M-Q>", "<cmd>quitall!<cr>", description = "Quit nvim" },

  -- Multi-cursor
  {
    "<M-d>",
    { n = "<Plug>(VM-Find-Under)", x = "<Plug>(VM-Find-Subword-Under)" },
    description = "Create cursor from selection",
  },
  { "<M-down>", "<Plug>(VM-Add-Cursor-Down)", description = "Add cursor below" },
  { "<M-up>", "<Plug>(VM-Add-Cursor-Up)", description = "Add cursor above" },

  -- Comments
  {
    "<C-/>",
    { n = "<Plug>(comment_toggle_linewise_current)", v = "<Plug>(comment_toggle_linewise_visual)" },
  },
  {
    "<M-/>",
    { n = "<Plug>(comment_toggle_linewise_current)", v = "<Plug>(comment_toggle_linewise_visual)" },
  },

  -- Word-wrap movement
  { "k", "v:count == 0 ? 'gk' : 'k'", opts = { expr = true } },
  { "j", "v:count == 0 ? 'gj' : 'j'", opts = { expr = true } },

  --- oil not vinegar
  {
    "-",
    function()
      vim.cmd.edit { args = { vim.fn.expand "%:p:h" } }
    end,
    description = "Explore current directory",
  },

  -- Yanky
  { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
  { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
  { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
  { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
  { "<c-j>", "<Plug>(YankyCycleForward)" },
  { "<c-k>", "<Plug>(YankyCycleBackward)" },

  -- substitute
  {
    "s",
    {
      n = "<cmd>lua require('substitute').operator()<cr>",
      x = "<cmd>lua require('substitute').visual()<cr>",
    },
  },
  { "ss", "<cmd>lua require('substitute').line()<cr>" },
  { "S", "<cmd>lua require('substitute').eol()<cr>" },

  -- exchange
  { "sx", "<cmd>lua require('substitute.exchange').operator()<cr>" },
  { "sxx", "<cmd>lua require('substitute.exchange').line()<cr>" },
  { "X", "<cmd>lua require('substitute.exchange').visual()<cr>", mode = { "x" } },
  { "sxc", "<cmd>lua require('substitute.exchange').cancel()<cr>" },
}

wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 2, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 10,
  },
  layout = {
    height = { min = 3, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 5, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
}

-- [<leader>]
local leader_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local leader_mappings = {
  ["?"] = { "<cmd>Legendary<cr>", "Command palette" },
  [";"] = { "<cmd>Alpha<cr>", "Go to dashboard" },
  ["S"] = { "<cmd>TSJSplit<cr>", "Split block" },
  ["J"] = { "<cmd>TSJJoin<cr>", "Join block" },
  ["M"] = { "<cmd>TSJToggle<cr>", "Split/join block" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["E"] = { "<cmd>NvimTreeFindFile<cr>", "Explorer (reveal current file)" },
  ["w"] = {
    function()
      reload("lvim.utils").save()
    end,
    "Format and Save",
  },
  ["q"] = {
    name = "[q]uickfix",
    ["q"] = { require("lvim.utils").toggle_quickfix, "Toggle quickfix" },
    ["l"] = { require("lvim.utils").toggle_loc, "Toggle location list" },
  },
  ["f"] = {
    name = "[f]iles",
    ["f"] = { "<cmd>Telescope find_files<cr>", "Find files" },
    ["o"] = {
      "<cmd>lua require('telescope.builtin').buffers()<cr>",
      "Find open buffers",
    },
    ["m"] = {
      "<cmd>Telescope oldfiles<cr>",
      "Recent files",
    },
  },
  ["s"] = {
    name = "[s]earch",
    ["s"] = { "<cmd>Telescope live_grep<cr>", "Find text (live)" },
    ["w"] = { "<cmd>Telescope grep_string<cr>", "Find text at cursor (live)" },
    ["g"] = "Find text",
  },
  ["p"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["<Tab>"] = { "<c-6>", "Move back and forth" },
  ["="] = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
  ["h"] = {
    name = "hunks",
    ["t"] = { vgit.toggle_live_guttter, "Toggle live gutter" },
    ["s"] = { vgit.buffer_hunk_stage, "Stage Hunk" },
    ["p"] = { vgit.buffer_hunk_preview, "Preview Hunk" },
    ["u"] = { vgit.buffer_hunk_reset, "Undo Hunk" },
    ["R"] = { vgit.buffer_unstage, "Reset Buffer" },
    ["l"] = { vgit.buffer_blame_preview, "Blame line" },
    ["b"] = { vgit.toggle_live_blame, "Toggle live blame" },
    ["a"] = { vgit.toggle_authorship_code_lens, "Toggle authors" },
  },
  ["t"] = {
    name = "[t]esting",
    ["t"] = { [[<cmd>lua require("neotest").run.run()<cr>]], "Run Nearest" },
    ["f"] = { [[<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>]], "Run File" },
    ["s"] = { [[<cmd>lua require("neotest").run.stop()<cr>]], "Stop test" },
    ["."] = { [[<cmd>lua require("neotest").run.run_last()<cr>]], "Run Last" },
    ["d"] = { [[<cmd>lua require("neotest").run.run_last({strategy = "dap"})<cr>]], "Debug Last" },
    ["o"] = { [[<cmd>lua require("neotest").output.open({ enter = true })<cr>]], "Show test output" },
  },
  ["k"] = {
    name = "tas[k]s",
    ["r"] = { "<cmd>OverseerRun<cr>", "Run task" },
    ["t"] = { "<cmd>OverseerToggle<cr>", "Toggle tasks window" },
    ["a"] = { "<cmd>OverseerTaskAction<cr>", "Select a task action to run" },
    ["i"] = { "<cmd>OverseerInfo<cr>", "Show tasks info" },
  },
  ["j"] = {
    name = "[l]jumps",
    ["j"] = { "<cmd>HopAnywhere<cr>", "Jump anywhere" },
    ["w"] = { "<cmd>HopWord<cr>", "Jump words" },
    ["p"] = { "<cmd>HopPattern<cr>", "Jump patterns" },
    ["l"] = { "<cmd>HopLineStart<cr>", "Jump lines" },
    ["c"] = { "<cmd>HopChar1<cr>", "Jump character" },
    ["v"] = { "<cmd>HopVertical<cr>", "Jump vertically" },
  },
  ["x"] = {
    name = "[x]sessions",
    ["s"] = {
      function()
        require("resession").save()
      end,
      "Save session",
    },
    ["l"] = {
      function()
        require("resession").load()
      end,
      "Load session",
    },
    ["d"] = {
      function()
        require("resession").delete()
      end,
      "Delete session",
    },
  },
  ["n"] = {
    name = "[n]otifications",
    ["r"] = { "<cmd>Telescope notify<cr>", "Browse recent notifications" },
    ["h"] = { "<cmd>Noice history<cr>", "Browse notification history" },
    ["l"] = { "<cmd>Noice log<cr>", "Browse log" },
  },
  ["l"] = {
    name = "[l]sp",
    ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    ["d"] = {
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      "Document Diagnostics",
    },
    ["w"] = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics",
    },
    ["h"] = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle inlay hints" },
    ["i"] = { "<cmd>LspInfo<cr>", "Info" },
    ["I"] = { "<cmd>Mason<cr>", "Installer (Mason)" },
    ["l"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    ["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    ["s"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Document Symbols" },
    ["q"] = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    ["S"] = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
}
wk.register(leader_mappings, leader_opts)
wk.register({
  ["="] = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
}, tbl.merge(leader_opts, { mode = "x" }))

local g_mappings = {
  ["d"] = { "<cmd>Telescope lsp_definitions<cr>", "Go to definition" },
  ["r"] = { "<cmd>Telescope lsp_references<cr>", "Go to references" },
  ["i"] = { "<cmd>Telescope lsp_implementations<cr>", "Go to implementations" },
  ["l"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open float" },
}
-- Go to [g]
local goto_opts = {
  mode = "n", -- NORMAL mode
  prefix = "g",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
wk.register(g_mappings, goto_opts)

-- [] pairs
local pair_opts = {
  mode = "n", -- NORMAL mode
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local pair_mappings = {
  ["d"] = {
    prev = "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
    next = "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
    desc = "%s diagnostic",
  },
  ["h"] = {
    prev = "<cmd>lua require('vgit').hunk_up()<cr>",
    next = "<cmd>lua require('vgit').hunk_down()<cr>",
    desc = "%s hunk",
  },
}

local prev_mappings = {}
local next_mappings = {}
for index, value in pairs(pair_mappings) do
  prev_mappings[index] = { value.prev, string.format(value.desc, "Previous") }
  next_mappings[index] = { value.next, string.format(value.desc, "Next") }
end

wk.register(prev_mappings, tbl.merge(pair_opts, { prefix = "[" }))
wk.register(next_mappings, tbl.merge(pair_opts, { prefix = "]" }))

-- for some reason this doesn't work through whichkey
vim.keymap.set("n", "<leader>sg", ":silent! grep! ", {
  desc = "Find text",
})

-- readline bindings
vim.keymap.set({ "i", "c" }, "<C-b>", "<Left>")
vim.keymap.set({ "i", "c" }, "<M-b>", "<C-Left>")

vim.keymap.set({ "i", "c" }, "<C-f>", "<Right>")
vim.keymap.set({ "i", "c" }, "<M-f>", "<C-Right>")

vim.keymap.set({ "i", "c" }, "<C-d>", "<Del>")
vim.keymap.set({ "i", "c" }, "<M-d>", "<C-Right><C-w>")
vim.keymap.set({ "i", "c" }, "<C-h>", "<BS>")

vim.keymap.set({ "i", "c" }, "<C-a>", "<Home>")
vim.keymap.set({ "i", "c" }, "<C-e>", "<End>")
