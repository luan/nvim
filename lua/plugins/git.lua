local review_request_file = "/tmp/nvim-review-request"

local function setup_lazygit_review_hook()
  vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*lazygit*",
    callback = function()
      vim.defer_fn(function()
        local f = io.open(review_request_file, "r")
        if not f then
          return
        end
        local content = f:read("*a")
        f:close()
        os.remove(review_request_file)

        local lines = vim.split(content, "\n", { trimempty = true })
        if #lines >= 2 then
          require("review").open_commits(lines[1], lines[2])
        elseif #lines == 1 then
          require("review").open_commits(lines[1] .. "^", lines[1])
        end
      end, 100)
    end,
  })
end

return {
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  {
    "luan/review.nvim",
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
    config = function(_, opts)
      require("review").setup(opts)
      setup_lazygit_review_hook()
    end,
  },
}
