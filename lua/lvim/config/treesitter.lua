require("nvim-treesitter.configs").setup {
  auto_install = true,
  sync_install = false,
  ensure_installed = { "typescript", "lua", "go", "svelte", "c", "vim", "help" },
  ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
  autopairs = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml", "python" } },
  context_commentstring = {
    enable = true,
  },
  autotag = {
    enable = true,
    disable = { "xml", "markdown" },
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    disable = { "html" },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ["<A-l>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<A-h>"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next = {
        ["]c"] = "@conditional.outer",
        ["]a"] = "@parameter.outer",
        ["]f"] = "@funcion.outer",
      },
      goto_previous = {
        ["[c"] = "@conditional.outer",
        ["[a"] = "@parameter.outer",
        ["[f"] = "@funcion.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  endwise = { enabled = true },
}

require("nvim-ts-autotag").setup {
  enable = true,
  filetypes = {
    "html",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "svelte",
    "vue",
    "tsx",
    "jsx",
    "rescript",
    "xml",
    "php",
    "markdown",
    "glimmer",
    "handlebars",
    "hbs",
  },
}

require("hlargs").setup()
