return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers",
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      separator_style = "slant",
      always_show_bufferline = false,
      diagnostics = "nvim_lsp",
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
  },
}
