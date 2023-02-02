local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local proximity_sort = require "lvim.utils.proximity_sort"
local current_path = require("lvim.utils").current_path
local actions = require "telescope.actions"

local themes = require("lvim.core.telescope").themes

local function proximity_sort_tiebreak(current_entry, existing_entry, _)
  return proximity_sort(current_entry.ordinal, existing_entry.ordinal, current_path "#")
end

telescope.setup {
  active = true,
  on_config_done = nil,
  defaults = {
    theme = themes.dropdown,
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    layout_strategy = nil,
    layout_config = {
      horizontal = {
        sorting_strategy = "ascending",
        prompt_position = "top",
      },
      vertical = {
        mirror = false,
      },
    },
    tiebreak = proximity_sort_tiebreak,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    -- borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_ignore_patterns = {
      "/home/loc/.config/nvim",
      ".git/",
      "target/",
      "docs/",
      "vendor/*",
      "%.lock",
      "__pycache__/*",
      "%.sqlite3",
      "%.ipynb",
      "node_modules/*",
      -- "%.jpg",
      -- "%.jpeg",
      -- "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "%.webp",
      ".dart_tool/",
      ".github/",
      ".gradle/",
      ".idea/",
      ".settings/",
      ".vscode/",
      "__pycache__/",
      "build/",
      "env/",
      "gradle/",
      "node_modules/",
      "%.pdb",
      "%.dll",
      "%.class",
      "%.exe",
      "%.cache",
      "%.ico",
      "%.pdf",
      "%.dylib",
      "%.jar",
      "%.docx",
      "%.met",
      "smalljre_*/*",
      ".vale/",
      "%.burp",
      "%.mp4",
      "%.mkv",
      "%.rar",
      "%.zip",
      "%.7z",
      "%.tar",
      "%.bz2",
      "%.epub",
      "%.flac",
      "%.tar.gz",
    },
  },
  pickers = {
    find_files = tbl.merge(themes.dropdown, {
      hidden = true,
    }),
    commands = tbl.merge(themes.dropdown, {
      hidden = true,
      prompt_prefix = " ",
    }),
    live_grep = tbl.merge(themes.center, {
      --@usage don't include the filename in the search results
      only_sort_text = true,
      prompt_prefix = " ",
    }),
    grep_string = {
      only_sort_text = true,
    },
    buffers = tbl.merge(themes.dropdown, {
      preview = false,
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    }),
    planets = {
      show_pluto = true,
      show_moon = true,
    },
    git_files = {
      hidden = true,
      show_untracked = true,
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}

require("telescope").load_extension "fzf"
require("telescope").load_extension "projects"
require("telescope").load_extension "frecency"
