-- Helper function to list all window paths with @ prefix
local function list_window_paths()
  local file_paths = {}
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(w)
    local bufname = vim.api.nvim_buf_get_name(buf)
    
    -- Skip empty buffers, special buffers, and non-file buffers
    if bufname ~= "" and 
       vim.bo[buf].buftype == "" and 
       vim.fn.filereadable(bufname) == 1 then
      local relative_path = vim.fn.fnamemodify(bufname, ":.")
      table.insert(file_paths, "@" .. relative_path)
    end
  end
  
  return table.concat(file_paths, " ")
end

-- Helper function to get harpoon files with @ prefix
local function get_harpoon_files()
  local ok, harpoon = pcall(require, "harpoon")
  if not ok then
    return ""
  end

  local list = harpoon:list()
  local items = list.items

  local file_paths = {}
  for _, item in ipairs(items) do
    if item.value and item.value ~= "" then
      table.insert(file_paths, "@" .. item.value)
    end
  end

  return table.concat(file_paths, " ")
end

return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      window = {
        position = "float",
        float = {
          width = "40%",
          height = "90%",
          row = "center",
          col = "60%",
          relative = "editor",
          border = "single",
        },
      },
      refresh = {
        enable = true, -- Enable file change detection
        updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
        timer_interval = 1000, -- How often to check for file changes (milliseconds)
        show_notifications = true, -- Show notification when files are reloaded
      },
      keymaps = {
        toggle = {
          normal = "<M-i>", -- Normal mode keymap for toggling Claude Code, false to disable
          terminal = "<M-i>", -- Terminal mode keymap for toggling Claude Code, false to disable
          variants = {
            continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
            verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
          },
        },
        window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
        scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
      },
      scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
    })

    -- Set up custom keymaps for Claude Code terminal
    vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
      pattern = "*",
      callback = function(ev)
        -- Check if this is a terminal buffer
        if vim.bo[ev.buf].buftype == "terminal" then
          -- Set buffer-local keymaps for terminal mode
          vim.keymap.set("t", "@@", function()
            local content = list_window_paths()
            vim.api.nvim_feedkeys(content, "n", false)
          end, { buffer = ev.buf, desc = "Insert window paths" })

          vim.keymap.set("t", "hh", function()
            local content = get_harpoon_files()
            if content ~= "" then
              vim.api.nvim_feedkeys(content, "n", false)
            end
          end, { buffer = ev.buf, desc = "Insert harpoon files" })
        end
      end,
    })
  end,
}
