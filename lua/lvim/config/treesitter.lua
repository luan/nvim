require("nvim-treesitter.configs").setup {
   -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
   ensure_installed = {
      "bash",
      "help",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "yaml",
   },
   sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
   ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
   autopairs = {
      enable = true,
   },
   highlight = {
      enable = true, -- false will disable the whole extension
      -- disable = { "scss", "css" }, -- list of language that will be disabled
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
      colors = {
         -- lvim.color_base.blue,
         -- lvim.color_base.red,
         -- lvim.color_base.magenta,
         -- lvim.color_base.cyan,
         -- lvim.color_base.green,
         -- lvim.color_base.yellow,
      },
      disable = { "html" },
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
