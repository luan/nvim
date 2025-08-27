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
--
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

local function insert_content(func)
  return function()
    vim.api.nvim_feedkeys(func(), "n", false)
  end
end

return {
  {
    "pittcat/claude-fzf.nvim",
    dependencies = {
      "ibhagwan/fzf-lua",
      "coder/claudecode.nvim",
    },
    opts = {
      auto_context = true,
      batch_size = 10,
    },
    cmd = {
      "ClaudeFzf",
      "ClaudeFzfFiles",
      "ClaudeFzfGrep",
      "ClaudeFzfBuffers",
      "ClaudeFzfGitFiles",
      "ClaudeFzfDirectory",
    },
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<D-i>", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<D-l>", "<cmd>ClaudeCode<cr>", desc = "Focus Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    opts = {
      terminal = {
        split_width_percentage = 0.30,

        snacks_win_opts = {
          keys = {
            claude_insert = {
              "<D-i>",
              function()
                vim.cmd("startinsert")
              end,
              mode = { "t", "n" },
              desc = "Insert",
            },
            claude_hide = {
              "<D-l>",
              function(self)
                self:hide()
              end,
              mode = { "t", "n" },
              desc = "Hide (Cmd+l)",
            },
            claude_close = { "<M-q>", "close", desc = "Close" },
            clean_paste = {
              "<C-S-v>",
              function()
                local handle = io.popen("pbpaste")
                if handle then
                  local content = handle:read("*a")
                  handle:close()
                  if content and content ~= "" then
                    -- Clean escape sequences inline
                    content = content:gsub("\027%[200~", "")
                    content = content:gsub("\027%[201~", "")
                    vim.api.nvim_feedkeys(content, "n", false)
                  end
                end
              end,
              mode = "t",
              desc = "Clean Paste",
            },
            nvim_socket = {
              ";;",
              insert_content(get_socket_prompt),
              mode = "t",
              desc = "Insert nvim socket",
            },
            current_file = {
              "@.",
              insert_content(list_window_paths),
              mode = "t",
              desc = "Insert window file paths",
            },
            open_buffers = {
              "@,",
              insert_content(list_all_buffers),
              mode = "t",
              desc = "Insert current open buffers",
            },
            fzf_files = {
              "@@",
              function()
                require("claude-fzf").files()
              end,
              mode = "t",
              desc = "Close",
            },
          },
        },
      },
    },
  },
}
