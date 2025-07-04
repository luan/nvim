return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true },
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 60,
              position = "left",
            },
          },
          actions = {
            confirm = {
              action = function(picker, item)
                if not item then return end
                vim.cmd("edit " .. item.file)
                vim.schedule(function()
                  vim.cmd("normal! zz")
                end)
              end,
            },
          },
        },
      },
    },
  },
}
