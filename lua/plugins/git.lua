return {
  { "NeogitOrg/neogit" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "nvim-lua/plenary.nvim" },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- lazy, only load diffview by these commands
    cmd = {
      "DiffviewFileHistory",
      "DiffviewOpen",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
  },
}
