local readline = require("readline")

return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Always enforce: no title bar for terminals (splits or floats)
    local cfg = {
      terminal = {
        win = {
          wo = {
            winbar = "",
          },
        },
      },
    }

    -- If trouble.nvim is available, extend Snacks picker actions/mappings
    if LazyVim.has("trouble.nvim") then
      cfg.picker = {
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
      }
    end

    return vim.tbl_deep_extend("force", opts or {}, cfg)
  end,
}
