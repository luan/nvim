return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      watch_for_changes = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
      default_file_explorer = true,
      keymaps = {
        ["gd"] = function()
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        end,
        ["gD"] = function()
          require("oil").set_columns({ "icon" })
        end,
      },
    },
    -- Optional dependencies
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open parent directory in Oil",
      },
    },
  },
}
