return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = false,
        },
      },
      window = {
        width = 50,
        mappings = {
          ["/"] = false,
          ["<space>"] = "fuzzy_finder",
          ["s"] = false,
          ["S"] = false,
          ["<c-cr>"] = "open_vsplit",
          ["-"] = "close_node",
          ["z"] = "close_all_subnodes",
          ["Z"] = "expand_all_subnodes",
        },
      },
    },
    keys = {
      { "<leader>E", false },
      { "<leader>e", false },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ reveal = true, dir = LazyVim.root() })
        end,
        desc = "Focus Neo-tree",
      },
      {
        "<D-e>",
        "<leader>e",
        desc = "Focus Neo-tree",
        remap = true,
      },
      {
        "<D-b>",
        function()
          require("neo-tree.command").execute({ action = "show", toggle = true, reveal = false, dir = LazyVim.root() })
        end,
        desc = "Toggle Neo-tree",
      },
    },
  },
}
