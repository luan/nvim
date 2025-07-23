return {
  "nvim-lua/lsp-status.nvim",
  event = "LspAttach",
  config = function()
    local lsp_status = require("lsp-status")
    lsp_status.config({
      status_symbol = "",
      indicator_errors = LazyVim.config.icons.diagnostics.Error,
      indicator_warnings = LazyVim.config.icons.diagnostics.Warn,
      indicator_info = LazyVim.config.icons.diagnostics.Info,
      indicator_hint = LazyVim.config.icons.diagnostics.Hint,
      indicator_ok = LazyVim.config.icons.diagnostics.Ok,
      spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
      select_symbol = function(cursor_pos, symbol)
        if symbol.valueRange then
          local value_range = {
            ["start"] = {
              character = 0,
              line = vim.fn.byte2line(symbol.valueRange[1]),
            },
            ["end"] = {
              character = 0,
              line = vim.fn.byte2line(symbol.valueRange[2]),
            },
          }
          return require("lsp-status.util").in_range(cursor_pos, value_range)
        end
      end,
      current_function = true,
    })
    lsp_status.register_progress()
  end,
}
