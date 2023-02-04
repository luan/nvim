vim.g.codeium_disable_bindings = 1

vim.keymap.set("i", "<M-l>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
vim.keymap.set("i", "<M-n>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true })
vim.keymap.set("i", "<M-p>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true })
vim.keymap.set("i", "<M-k>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true })
