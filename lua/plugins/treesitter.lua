local function config()
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    refactor = {
      highlight_definitions = { enable = true },
      -- highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false -- Whether the query persists across vim sessions
    },
    rainbow = {
      enable = true,
      disable = { "html" },
      extended_mode = false,
      max_file_lines = nil,
    },
    autotag = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },

    ensure_installed = {
      "c",
      "c_sharp",
      "clojure",
      "cmake",
      "comment",
      "cpp",
      "css",
      "d",
      "dart",
      "dockerfile",
      "dot",
      "elixir",
      "elm",
      "erlang",
      "fennel",
      "fish",
      "fortran",
      "go",
      "godot_resource",
      "gomod",
      "gowork",
      "graphql",
      "hack",
      "haskell",
      "hcl",
      "help",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "kotlin",
      "latex",
      "llvm",
      "lua",
      "make",
      "markdown",
      "ninja",
      "nix",
      "pascal",
      "perl",
      "php",
      "python",
      "ql",
      "query",
      "r",
      "regex",
      "rst",
      "ruby",
      "rust",
      "scala",
      "scheme",
      "scss",
      "svelte",
      "swift",
      "teal",
      "todotxt",
      "toml",
      "tsx",
      "turtle",
      "typescript",
      "verilog",
      "vim",
      "vue",
      "yaml",
    },
  }
end

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = config,
}
