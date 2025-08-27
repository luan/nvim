local readline = require("readline")
local select_layout = {
  preview = false,
  layout = {
    backdrop = true,
    width = 0.5,
    min_width = 80,
    height = 0.35,
    min_height = 3,
    box = "vertical",
    border = "none",
    { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
    { win = "list", border = "hpad" },
    { win = "preview", title = "{preview}", height = 0.6, border = "hpad" },
  },
}
local regex_toggle = {
  toggles = {
    regex = { value = true },
  },
  win = {
    input = {
      keys = {
        ["<a-r>"] = { "toggle_regex", mode = { "n", "i" }, desc = "Toggle Regex" },
      },
    },
  },
}

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local term_title = vim.b.term_title
    if term_title and term_title:match("lazygit") then
      -- Create lazygit specific mappings
      vim.keymap.set("t", "<C-g>", "<cmd>close<cr>", { buffer = true })
      vim.keymap.set("t", "<C-c>", "<cmd>close<cr>", { buffer = true })
    end
  end,
})

return {
  "folke/snacks.nvim",
  opts = {
    -- dashboard = { enabled = false },

    indent = {
      indent = {
        char = "┊",
      },

      scope = {
        underline = false,
        char = "┊",
        hl = "NonText",
      },

      chunk = {
        enabled = false,
        hl = "NonText",
        char = {
          -- corner_top = "┌",
          -- corner_bottom = "└",
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "┄",
          vertical = "┊",
          arrow = "╼",
        },
      },
    },

    -- Always enforce: no title bar for terminals (splits or floats)
    terminal = {
      win = {
        wo = {
          winbar = "",
        },
        keys = {
          ["<esc><esc>"] = false,
        },
      },
    },

    lazygit = {
      config = {
        confirmOnQuit = true,

        keybinding = {
          universal = {
            quit = "Q",
          },
        },
      },
    },

    picker = {
      sources = {
        files = { layout = select_layout },
        buffers = { layout = select_layout },
        grep = regex_toggle,
        grep_buffers = regex_toggle,
        grep_word = regex_toggle,
      },
      actions = {
        trouble_open = function(...)
          return require("trouble.sources.snacks").actions.trouble_open.action(...)
        end,
        cursor_right = function()
          return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "", false)
        end,
        cursor_left = function()
          return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, true, true), "", false)
        end,
        delete = function()
          return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Delete>", true, true, true), "", false)
        end,
        backspace = function()
          return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>", true, true, true), "", false)
        end,
      },
      win = {
        input = {
          keys = {
            ["<D-a>"] = { "select_all", mode = { "n", "i" } },

            ["<c-a>"] = { readline.beginning_of_line, mode = { "i" } },
            ["<c-e>"] = { readline.end_of_line, mode = { "i" } },
            ["<c-u>"] = { readline.backward_kill_line, mode = { "i" } },
            ["<c-k>"] = { readline.kill_line, mode = { "i" } },
            ["<c-f>"] = { "cursor_right", mode = "i" },
            ["<c-b>"] = { "cursor_left", mode = { "i" } },
            ["<c-d>"] = { "delete", mode = { "i" } },
            ["<c-h>"] = { "backspace", mode = { "i" } },
            ["<c-n>"] = { "list_down", mode = { "i" } },
            ["<c-p>"] = { "list_up", mode = { "i" } },
            ["<c-w>"] = { readline.unix_word_rubout, mode = { "i" } },
            ["<m-b>"] = { readline.backward_word, mode = { "i" } },
            ["<m-f>"] = { readline.forward_word, mode = { "i" } },
            ["<m-d>"] = { readline.kill_word, mode = { "i" } },
            ["<m-BS>"] = { readline.backward_kill_word, mode = { "i" } },
            ["<a-t>"] = {
              "trouble_open",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>'",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
  },
}
