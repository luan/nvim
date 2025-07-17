return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
      {
        "<leader>0",
        function()
          local harpoon = require("harpoon")
          local list = harpoon:list()
          local items = list.items

          local file_paths = {}
          for _, item in ipairs(items) do
            if item.value and item.value ~= "" then
              table.insert(file_paths, "@" .. item.value)
            end
          end

          if #file_paths > 0 then
            local clipboard_content = table.concat(file_paths, " ")
            vim.fn.setreg("+", clipboard_content)
            vim.notify("Copied " .. #file_paths .. " harpoon files to clipboard", vim.log.levels.INFO)
          else
            vim.notify("No harpoon files to copy", vim.log.levels.WARN)
          end
        end,
        desc = "Copy Harpoon Files to Clipboard",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
}
