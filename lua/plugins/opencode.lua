-- opencode.nvim configuration based on lua/plugins/claude.lua
-- Uses: https://github.com/NickvanDyke/opencode.nvim

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

-- Helper that gathers harpoon file paths
local function harpoon_paths(opts)
  opts = opts or {}
  local ok, harpoon = pcall(require, "harpoon")
  if not ok then
    return ""
  end
  local list = harpoon:list()
  local items = list.items

  local paths = {}
  for _, item in ipairs(items) do
    if item.value and item.value ~= "" then
      if opts.prefix_at then
        table.insert(paths, "@" .. item.value)
      else
        table.insert(paths, item.value)
      end
    end
  end
  return table.concat(paths, opts.sep or ", ")
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
  "NickvanDyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  -- stylua: ignore
  keys = {
    { '<leader>it', function() require('opencode').toggle() end,                     desc = 'Toggle embedded opencode' },

    { '<leader>ia', function() require('opencode').ask() end,                        desc = 'Ask opencode', mode = 'n' },
    { '<leader>ia', function() require('opencode').ask('@selection: ') end,          desc = 'Ask opencode about selection', mode = 'v' },

    { '<leader>ip', function() require('opencode').select_prompt() end,              desc = 'Select prompt', mode = { 'n', 'v' } },

    { '<leader>in', function() require('opencode').command('session_new') end,       desc = 'New session' },
    { '<leader>iy', function() require('opencode').command('messages_copy') end,     desc = 'Copy last message' },

    { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up' },
    { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down' },
  },
  opts = function(_, opts)
    -- Ensure socket path is stored (mirrors claude.lua behavior)
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

    -- Augment default options with a custom @harpoon context
    opts = opts or {}
    opts.contexts = vim.tbl_deep_extend("force", opts.contexts or {}, {
      ["@harpoon"] = {
        description = "Files tagged by harpoon",
        value = function()
          local paths = harpoon_paths({ prefix_at = false, sep = ", " })
          if paths == "" then
            return nil
          end
          return paths
        end,
      },
    })

    -- Prefer default terminal/input options from plugin; nothing else to override here
    return opts
  end,
  config = function(_, _)
    -- Register terminal autocmds for embedded opencode terminal: unlist, paste, helpers
    vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
      pattern = "*",
      callback = function(ev)
        if vim.bo[ev.buf].buftype == "terminal" then
          local bufname = vim.api.nvim_buf_get_name(ev.buf)
          if bufname:match("opencode") and bufname:match("term://") then
            -- Make buffers unlisted
            vim.api.nvim_set_option_value("buflisted", false, { buf = ev.buf })
            -- Setup Ctrl+Shift+V paste (clean bracketed paste escapes)
            vim.keymap.set("t", "<C-S-v>", function()
              local handle = io.popen("pbpaste")
              if handle then
                local content = handle:read("*a")
                handle:close()
                if content and content ~= "" then
                  content = content:gsub("\027%[200~", "")
                  content = content:gsub("\027%[201~", "")
                  vim.api.nvim_feedkeys(content, "n", false)
                end
              end
            end, { buffer = ev.buf, desc = "Paste cleaned - Ctrl+Shift+V" })
          end

          -- Buffer-local helpers for terminal mode, regardless of which terminal
          vim.keymap.set("t", "@@", function()
            local content = list_window_paths()
            vim.api.nvim_feedkeys(content, "n", false)
          end, { buffer = ev.buf, desc = "Insert window paths" })

          vim.keymap.set("t", ",,", function()
            local content = list_all_buffers()
            vim.api.nvim_feedkeys(content, "n", false)
          end, { buffer = ev.buf, desc = "Insert all buffer paths" })

          vim.keymap.set("t", "hh", function()
            local content = harpoon_paths({ prefix_at = true, sep = " " })
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
      pattern = "*opencode*",
      callback = function(ev)
        vim.api.nvim_set_option_value("buflisted", false, { buf = ev.buf })
      end,
    })

    -- Commands to show/debug socket info
    vim.api.nvim_create_user_command("OpencodeSocketPath", function()
      local socket_path = vim.g.nvim_socket_path
      if socket_path then
        print("Socket path: " .. socket_path)
        vim.fn.setreg("+", socket_path)
      else
        print("No socket server running")
      end
    end, { desc = "Show socket path" })

    vim.api.nvim_create_user_command("OpencodeSocketDebug", function()
      print("Socket path: " .. (vim.g.nvim_socket_path or "not set"))
      print("Server name: " .. (vim.v.servername or "not set"))
      print("Socket prompt: " .. get_socket_prompt())
    end, { desc = "Debug socket status" })
  end,
}
