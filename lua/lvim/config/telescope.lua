local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local proximity_sort = require "lvim.utils.proximity_sort"
local current_path = require("lvim.utils").current_path
local actions = require "telescope.actions"

---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme

local center_theme = {
  borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
  layout_config = {
    sorting_strategy = "ascending",
    horizontal = {
      prompt_position = "top",
      preview_width = 0.55,
      results_width = 0.8,
    },
    vertical = {
      mirror = false,
    },
    width = 0.87,
    height = 0.80,
    preview_cutoff = 120,
  },
}

local cursor_theme = require("telescope.themes").get_cursor {
  borderchars = { "█", "█", "▀", "█", "█", "█", "▀", "▀" },
}

local dropdown_theme = require("telescope.themes").get_dropdown {
  borderchars = { "█", "█", "▀", "█", "█", "█", "▀", "▀" },
  width = 0.5,
  prompt = " ",
  results_height = 15,
  previewer = false,
  winblend = 0,
}

local function proximity_sort_tiebreak(current_entry, existing_entry, _)
  return proximity_sort(current_entry.ordinal, existing_entry.ordinal, current_path "#")
end

telescope.setup {
  active = true,
  on_config_done = nil,
  defaults = {
    theme = "dropdown", ---@type telescope_themes
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    -- sorting_strategy = nil,
    layout_strategy = nil,
    layout_config = {},
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
    borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
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
    find_files = tbl.merge(dropdown_theme, {
      hidden = true,
    }),
    commands = tbl.merge(dropdown_theme, {
      hidden = true,
      prompt_prefix = " ",
    }),
    live_grep = tbl.merge(center_theme, {
      --@usage don't include the filename in the search results
      only_sort_text = true,
      prompt_prefix = " ",
    }),
    grep_string = {
      only_sort_text = true,
    },
    buffers = tbl.merge(center_theme, {
      preview = false,
      initial_mode = "normal",
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
    ["ui-select"] = tbl.merge(cursor_theme),
  },
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "projects"
-- require("telescope").load_extension "frecency"
require("telescope").load_extension "ui-select"
