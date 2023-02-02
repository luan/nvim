require("lvim.lsp").setup("gopls", {
  hints = {
    assignVariableTypes = true,
    compositeLiteralFields = true,
    constantValues = true,
    functionTypeParameters = true,
    parameterNames = true,
    rangeVariableTypes = true,
  },
})
