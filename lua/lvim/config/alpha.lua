local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local theme = require "alpha.themes.startify"
local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
theme.section.header.val = {
  [[                                   __                ]],
  [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  [[     config by Luan Santos <https://github.com/luan>]],
  [[     Neovim Version: ]] .. version .. [[ (run :version for more details)]],
  [[]],
}

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
  vim.cmd.close()
end

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.cmd [[
        setlocal showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
        setlocal laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
      ]]
  end,
})

alpha.setup(theme.opts)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    vim.list_extend(
      theme.section.header.val,
      { "             Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
    )
    pcall(vim.cmd.AlphaRedraw)
  end,
})
