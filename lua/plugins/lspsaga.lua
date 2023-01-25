local function config()
  require('lspsaga').init_lsp_saga {
    error_sign = "✘",
    warn_sign = "➤",
    hint_sign = "",
    infor_sign = "➟",
    code_action_icon = "",
    code_action_prompt = { enable = true, sign = false, virtual_text = true },
    finder_action_keys = {
      open = "e",
      vsplit = "v",
      split = "s",
      quit = "q",
      scroll_down = "<C-f>",
      scroll_up = "<C-b>", -- quit can be a table
    },
    code_action_keys = { quit = "<ESC>", exec = "<CR>" },
  }
end

return {
  -- 'tami5/lspsaga.nvim',
  -- config = config,
}
