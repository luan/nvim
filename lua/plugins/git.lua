return {
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  {
    "georgeguimaraes/review.nvim",
    dependencies = {
      "esmuellert/codediff.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Review" },
    keys = {
      { "<leader>gr", "<cmd>Review<cr>", desc = "Review diff" },
      { "<leader>gR", "<cmd>Review commits<cr>", desc = "Review commits" },
      { "<leader>gP", "<cmd>Review preview<cr>", desc = "Preview review" },
      { "<leader>gS", "<cmd>Review sidekick<cr>", desc = "Send review to sidekick" },
    },
    opts = {},
  },
}
