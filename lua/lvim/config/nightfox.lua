require("nightfox").setup {
  options = {
    transparent = false,
    terminal_colors = true,
    dim_inactive = false,
    module_default = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    },
    inverse = {
      match_paren = false,
      visual = true,
      search = false,
    },
  },
  palettes = {},
  specs = {},
  groups = {},
}
