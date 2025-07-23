-- Helper function to list all window paths with @ prefix
local function list_window_paths()
  local file_paths = {}
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(w)
    local bufname = vim.api.nvim_buf_get_name(buf)

    -- Skip empty buffers, special buffers, and non-file buffers
    if bufname ~= "" and vim.bo[buf].buftype == "" and vim.fn.filereadable(bufname) == 1 then
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

-- Helper function to list all open buffers with @ prefix
local function list_all_buffers()
  local file_paths = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)

      -- Skip empty buffers, special buffers, and non-file buffers
      if bufname ~= "" and vim.bo[buf].buftype == "" and vim.fn.filereadable(bufname) == 1 then
        local relative_path = vim.fn.fnamemodify(bufname, ":.")
        table.insert(file_paths, "@" .. relative_path)
      end
    end
  end

  return table.concat(file_paths, " ")
end

-- Helper function to get the socket prompt
local function get_socket_prompt()
  local socket_path = vim.g.nvim_socket_path or vim.v.servername
  if socket_path and socket_path ~= "" then
    return "NVIM_SOCKET=" .. socket_path
  else
    return "No socket available - start neovim with --listen flag"
  end
end

return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    -- Ensure socket path is stored
    if vim.v.servername and vim.v.servername ~= "" then
      vim.g.nvim_socket_path = vim.v.servername

      -- Write socket path to a project-specific file for hooks
      local cwd = vim.fn.getcwd()
      local project_hash = vim.fn.sha256(cwd):sub(1, 8)
      local socket_file = "/tmp/nvim_socket_" .. project_hash
      local file = io.open(socket_file, "w")
      if file then
        file:write(vim.v.servername .. "\n" .. cwd)
        file:close()
      end
    end

    require("claude-code").setup({
      window = {
        position = "vertical",
        float = {
          width = "40%",
          height = "90%",
          row = "center",
          col = "60%",
          relative = "editor",
          border = "rounded",
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
          normal = false, -- Disable built-in normal mode toggle - we'll use our own
          terminal = false, -- Disable built-in terminal mode toggle - we'll use our own
          variants = {
            resume = "<D-S-i>", -- Normal mode keymap for Claude Code with continue flag
            verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
          },
        },
        window_navigation = false, -- Disable window navigation keymaps to allow readline
        scrolling = false, -- Enable scrolling keymaps (<C-f/b>) for page up/down
      },
      scrolling = false, -- Enable scrolling keymaps (<C-f/b>) for page up/down
    })

    -- Set up custom keymaps for Claude Code terminal
    vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
      pattern = "*",
      callback = function(ev)
        -- Check if this is a terminal buffer
        if vim.bo[ev.buf].buftype == "terminal" then
          -- Make claude-code buffers unlisted
          local bufname = vim.api.nvim_buf_get_name(ev.buf)
          if bufname:match("claude%-code") then
            vim.api.nvim_set_option_value("buflisted", false, { buf = ev.buf })
          end
          -- Set buffer-local keymaps for terminal mode
          vim.keymap.set("t", "@@", function()
            local content = list_window_paths()
            vim.api.nvim_feedkeys(content, "n", false)
          end, { buffer = ev.buf, desc = "Insert window paths" })

          vim.keymap.set("t", ",,", function()
            local content = list_all_buffers()
            vim.api.nvim_feedkeys(content, "n", false)
          end, { buffer = ev.buf, desc = "Insert all buffer paths" })

          vim.keymap.set("t", "hh", function()
            local content = get_harpoon_files()
            if content ~= "" then
              vim.api.nvim_feedkeys(content, "n", false)
            end
          end, { buffer = ev.buf, desc = "Insert harpoon files" })

          vim.keymap.set("t", ";;", function()
            local content = get_socket_prompt()
            vim.api.nvim_feedkeys(content, "n", false)
          end, { buffer = ev.buf, desc = "Insert socket prompt" })
        end
      end,
    })

    -- Also handle BufFilePost which fires after :file command
    vim.api.nvim_create_autocmd("BufFilePost", {
      pattern = "*claude-code*",
      callback = function(ev)
        vim.api.nvim_set_option_value("buflisted", false, { buf = ev.buf })
      end,
    })

    -- Command to show socket info
    vim.api.nvim_create_user_command("ClaudeSocketPath", function()
      local socket_path = vim.g.nvim_socket_path
      if socket_path then
        print("Socket path: " .. socket_path)
        vim.fn.setreg("+", socket_path) -- Copy to clipboard
      else
        print("No socket server running")
      end
    end, { desc = "Show socket path" })

    -- Debug command to check socket status
    vim.api.nvim_create_user_command("ClaudeSocketDebug", function()
      print("Socket path: " .. (vim.g.nvim_socket_path or "not set"))
      print("Server name: " .. (vim.v.servername or "not set"))
      print("Socket prompt: " .. get_socket_prompt())
    end, { desc = "Debug socket status" })
  end,
}
