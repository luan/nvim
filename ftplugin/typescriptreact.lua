require("lvim.lsp").setup("tsserver", {
  hints = {
    assignVariableTypes = true,
    compositeLiteralFields = true,
    constantValues = true,
    functionTypeParameters = true,
    parameterNames = true,
    rangeVariableTypes = true,
  },
})
require("lvim.lsp").setup("emmet_ls", {
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "css",
    "sass",
    "scss",
    "less",
    "eruby",
    "vue",
    "svelte",
  },
})
