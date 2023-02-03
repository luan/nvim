local resession = require "resession"

resession.setup {
  autosave = {
    enabled = true,
    interval = 60,
  },
  extensions = {
    overseer = {},
  },
}

local resession_group = vim.api.nvim_create_augroup("resession", { clear = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = resession_group,
  callback = function()
    resession.save(require("lvim.utils").get_session_name(), { dir = "dirsession", notify = false })
  end,
})
