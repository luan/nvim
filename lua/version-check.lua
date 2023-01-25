if vim.version().major == 0 and vim.version().minor < 8 then
  local fmt = string.format
  local version = vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
  vim.api.nvim_err_writeln(
    fmt('luan/nvim requires at least nvim-0.8.0 (current %s)', version)
  )
  vim.api.nvim_err_writeln('Please update Neovim')
  return
end
