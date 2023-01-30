require("fzf-lua").setup {
  files = {
    previewer = false,
  },
  height = 0.50,
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  -- This is required to support older version of fzf on remote devboxes
  fzf_opts = { ["--border"] = false },
  -- These settings reduce lag from slow git operations
  global_git_icons = false,
  git = {
    files = {
      previewer = false,
    },
  },
}
