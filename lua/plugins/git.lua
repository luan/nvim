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
  {
    dir = "~/src/fugit2.nvim",
    name = "fugit2.nvim",
    dev = true,
    build = false,
    opts = {
      width = 100,
      external_diffview = true,
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
        dependencies = { "stevearc/dressing.nvim" },
      },
    },
    cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
    keys = {
      { "<leader>gg", mode = "n", "<cmd>Fugit2<cr>" },
      { "<leader>gb", mode = "n", "<cmd>Fugit2Blame<cr>" },
      { "<leader>gd", mode = "n", "<cmd>DiffviewOpen<cr>" },
      { "<leader>gc", mode = "n", "<cmd>DiffviewClose<cr>" },
      { "<leader>gh", mode = "n", "<cmd>DiffviewFileHistory %<cr>" },
    },
  },
}
