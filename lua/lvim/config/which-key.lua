local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
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
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
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
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

which_key.setup(setup)

-- [<leader>]
local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  [";"] = { "<cmd>Alpha<cr>", "Go to dashboard" },
  ["B"] = {
    "<cmd>Neotree toggle show buffers left<cr>",
    "Buffers",
  },
  ["G"] = {
    "<cmd>Neotree toggle show git_status left<cr>",
    "Buffers",
  },
  ["s"] = { "<cmd>lua require('trevj').split_at_cursor()<cr>", "Split block" },
  ["j"] = { "<cmd>lua reload('trevj').join_at_cursor()<cr>", "Split block" },
  ["e"] = { "<cmd>Neotree toggle position=left<cr>", "Explorer" },
  ["E"] = { "<cmd>Neotree focus reveal position=left<cr>", "Explorer" },
  ["w"] = {
    function()
      reload("lvim.utils").save()
    end,
    "Format and Save",
  },
  ["q"] = { "<cmd>BufferClose<CR>", "Close Buffer" },
  ["o"] = {
    "<cmd>lua require('telescope.builtin').buffers()<cr>",
    "Find open buffers",
  },
  ["f"] = {
    "<cmd>lua require('fzf-lua').files()<cr>",
    "Find files",
  },
  -- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["g"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  ["p"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["<Tab>"] = { "<c-6>", "Move back and forth" },
  ["="] = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Installer (Mason)" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    r = { "<cmd>lua require('renamer').rename()<cr>", "Rename" },
    s = { "<cmd>lua vim.lsp.bug.signature_help()<cr>", "Document Symbols" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
}
which_key.register(mappings, opts)
which_key.register({
  ["="] = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
}, tbl.merge(opts, { mode = "x" }))

local g_mappings = {
  ["d"] = { "<cmd>Telescope lsp_definitions<cr>", "Go to definition" },
  ["r"] = { "<cmd>Telescope lsp_references<cr>", "Go to references" },
  ["i"] = { "<cmd>Telescope lsp_implementations<cr>", "Go to implementations" },
  ["b"] = { "<cmd>BufferLinePick<CR>", "Bufferline: pick buffer" },
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
which_key.register(g_mappings, goto_opts)