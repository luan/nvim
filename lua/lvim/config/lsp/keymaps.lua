local M = {}

M.on_attach = function(client, buffer)
  local opts = { noremap = true, silent = true }
  local map = vim.api.nvim_buf_set_keymap
  map(buffer, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  map(buffer, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  map(buffer, "n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
end

return M
