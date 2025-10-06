if true then
  return {}
end

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

return {
  "NickvanDyke/opencode.nvim",
  dependencies = { "folke/snacks.nvim" },
  -- stylua: ignore
  keys = {
    { '<D-i>', function() require('opencode').toggle() end,                     desc = 'Toggle embedded opencode' },
    { '<D-l>', function() require('opencode').toggle() end,                     desc = 'Toggle embedded opencode' },

    { '<D-k>', function() require('opencode').ask('@cursor: ') end,                        desc = 'Ask opencode', mode = 'n' },
    { '<D-k>', function() require('opencode').ask('@selection: ') end,          desc = 'Ask opencode about selection', mode = 'v' },

    { '<leader>in', function() require('opencode').command('session_new') end,       desc = 'New session' },
    { '<leader>iy', function() require('opencode').command('messages_copy') end,     desc = 'Copy last message' },

    { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up' },
    { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down' },
  },
  opts = {
    terminal = { win = { enter = true } },
  },
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
  end,
}
