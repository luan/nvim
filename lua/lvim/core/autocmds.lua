local augroup = vim.api.nvim_create_augroup("GeneralAutoCmds", { clear = true })

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup,
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q!<CR>", { noremap = true, silent = true })
    vim.cmd [[
		      set nobuflisted 
		]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup,
  pattern = { "*" },
  callback = function()
    vim.cmd [[set formatoptions-=cro]]
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup,
  pattern = { "" },
  callback = function()
    local get_project_dir = function()
      local cwd = vim.fn.getcwd()
      ---@diagnostic disable-next-line: missing-parameter
      local project_dir = vim.split(cwd, "/")
      local project_name = project_dir[#project_dir]
      return project_name
    end

    vim.opt.titlestring = get_project_dir()
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = augroup,
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup,
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.svelte", "*.vue" },
  callback = function()
    if vim.lsp.buf.server_ready() then
      vim.cmd [[silent! EslintFixAll]]
    end
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = augroup,
  callback = function()
    vim.cmd [[echon '']]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "help" },
  callback = function()
    vim.cmd [[wincmd L]]
  end,
})

vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  group = augroup,
  callback = function()
    vim.cmd [[cwindow]]
    vim.cmd [[lwindow]]
  end,
})
