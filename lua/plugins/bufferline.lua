local bg_inactive = "#11111b"
local bg_active = "#313244"

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  init = function()
    local bufline = require("catppuccin.groups.integrations.bufferline")
    function bufline.get()
      return bufline.get_theme()
    end
  end,
  opts = {
    options = {
      groups = {
        options = {
          toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        },
        items = {
          {
            name = " Generated",
            highlight = { underline = true, sp = "#313244" },
            autoclose = true,
            priority = 1,
            matcher = function(buf)
              -- Check filename patterns
              local filename_match = buf.name:match("%.lock") or buf.name:match("%-lock") or buf.name:match("%_lock")

              -- Check if first line contains "generated"
              local first_line_match = false
              if buf.path then
                local success, lines = pcall(vim.fn.readfile, buf.path, "", 1)
                if success and lines and #lines > 0 then
                  first_line_match = lines[1]:lower():match("generated")
                end
              end

              return filename_match or first_line_match
            end,
          },
          {
            name = " Ignored",
            highlight = { underline = true, sp = "#45475a" },
            priority = 1,
            matcher = function(buf)
              local filepath = buf.path
              if not filepath then
                return false
              end

              -- Cache git ignore status to avoid repeated system calls
              if not _G.git_ignore_cache then
                _G.git_ignore_cache = {}
              end

              if _G.git_ignore_cache[filepath] ~= nil then
                return _G.git_ignore_cache[filepath]
              end

              -- Check if file is ignored by git
              local cmd = string.format("git check-ignore %s", vim.fn.shellescape(filepath))
              vim.fn.system(cmd)
              local is_ignored = vim.v.shell_error == 0
              _G.git_ignore_cache[filepath] = is_ignored
              return is_ignored
            end,
          },
          {
            name = " Docs",
            highlight = { sp = "#74c7ec" },
            priority = 2,
            matcher = function(buf)
              return buf.name:match("%.md") or buf.name:match("%.txt")
            end,
          },
          {
            name = " Tests",
            highlight = { underline = true, sp = "#a6e3a1" },
            priority = 3,
            matcher = function(buf)
              return buf.name:match("%_test") or buf.name:match("%_spec") or buf.name:match("%Test")
            end,
          },
        },
      },
      mode = "buffers",
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = false,
      show_duplicate_prefix = true,
      separator_style = { "█", "█" },
      always_show_bufferline = true,
      diagnostics = "nvim_lsp",
      modified_icon = "",
      indicator = {
        style = "none",
      },
      hover = {
        enabled = true,
        delay = 200,
      },
      custom_filter = function(buf_number)
        local buf_type = vim.bo[buf_number].buftype
        local file_type = vim.bo[buf_number].filetype

        -- Hide non-file buffers
        if buf_type ~= "" then
          return false
        end

        -- Hide specific filetypes
        local excluded_filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lspinfo",
          "man",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        }

        for _, ft in ipairs(excluded_filetypes) do
          if file_type == ft then
            return false
          end
        end

        return true
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
    highlights = {
      background = { bg = bg_inactive },
      fill = { bg = bg_inactive },
      buffer_selected = { bg = bg_active },
      modified_selected = { bg = bg_active },
      duplicate_selected = { bg = bg_active },
      tab_selected = { bg = bg_active },
      indicator_selected = { bg = bg_active },
      separator_selected = { bg = bg_active },
      numbers_selected = { bg = bg_active },
      error_selected = { bg = bg_active },
      error_diagnostic_selected = { bg = bg_active },
      warning_selected = { bg = bg_active },
      warning_diagnostic_selected = { bg = bg_active },
      info_selected = { bg = bg_active },
      info_diagnostic_selected = { bg = bg_active },
      hint_selected = { bg = bg_active },
      hint_diagnostic_selected = { bg = bg_active },
      diagnostic_selected = { bg = bg_active },
    },
  },
}
