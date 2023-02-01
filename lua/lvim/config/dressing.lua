require("dressing").setup {
  input = {
    border = "rounded",
  },
  select = {
    enabled = true,
    telescope = require("lvim.core.telescope").themes.cursor,
  },
}
