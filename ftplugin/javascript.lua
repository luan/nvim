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
