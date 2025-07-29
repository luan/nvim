-- Centralized paste fix module for handling bracketed paste issues
-- Particularly for Claude Code terminal in Neovim + Ghostty

local M = {}

-- Clean escape sequences from text
function M.clean_escape_sequences(text)
  if not text then return "" end
  
  -- Remove bracketed paste markers
  text = text:gsub("\027%[200~", "")
  text = text:gsub("\027%[201~", "")
  
  -- Remove ANSI escape sequences
  text = text:gsub("\027%[[0-9;]*[mKHJ]", "")
  
  -- Remove other control sequences
  text = text:gsub("\027%][^\027]*\027\\", "")
  text = text:gsub("\027%][^\007]*\007", "")
  text = text:gsub("\027[^\027]*", "")
  
  -- Remove control characters except newlines and tabs
  text = text:gsub("[\001-\008\011-\031\127]", "")
  
  return text
end

-- Custom clipboard provider that cleans paste content
function M.setup_clipboard()
  vim.g.clipboard = {
    name = "macOS-clean-paste",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = function()
        local handle = io.popen("pbpaste -Prefer txt 2>/dev/null || pbpaste")
        local result = handle:read("*a")
        handle:close()
        return vim.split(M.clean_escape_sequences(result), "\n")
      end,
      ["*"] = function()
        local handle = io.popen("pbpaste -Prefer txt 2>/dev/null || pbpaste")
        local result = handle:read("*a")
        handle:close()
        return vim.split(M.clean_escape_sequences(result), "\n")
      end,
    },
    cache_enabled = 0,
  }
end

-- Disable bracketed paste mode terminal codes
function M.disable_bracketed_paste_codes()
  vim.cmd([[
    set t_BE=
    set t_BD=
    set t_PS=
    set t_PE=
  ]])
end

-- Send escape sequence to disable bracketed paste in Ghostty
function M.disable_ghostty_bracketed_paste()
  if vim.env.TERM_PROGRAM == "ghostty" then
    vim.schedule(function()
      io.stdout:write("\027[?2004l")
      io.stdout:flush()
    end)
  end
end

-- Setup autocmds for paste handling
function M.setup_autocmds()
  local group = vim.api.nvim_create_augroup("PasteFix", { clear = true })
  
  -- Disable bracketed paste in terminal buffers
  vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
      vim.opt_local.paste = false
    end,
    desc = "Disable bracketed paste in terminal",
  })
  
  -- Clean clipboard on focus
  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = function()
      local reg_content = vim.fn.getreg("+")
      if reg_content and reg_content:match("\027%[20[01]~") then
        vim.fn.setreg("+", M.clean_escape_sequences(reg_content))
      end
    end,
    desc = "Clean bracketed paste sequences from clipboard",
  })
end

-- Special handling for Claude Code terminal
function M.setup_claude_code_paste(buffer)
  local bufname = vim.api.nvim_buf_get_name(buffer)
  if not bufname:match("claude%-code") then
    return
  end
  
  -- Disable bracketed paste for this specific terminal
  vim.schedule(function()
    local chan = vim.bo[buffer].channel
    if chan and chan > 0 then
      pcall(vim.fn.chansend, chan, "\027[?2004l")
    end
  end)
  
  -- Custom paste handler for Claude Code
  local function claude_paste()
    local handle = io.popen("pbpaste")
    local clipboard_content = handle:read("*a")
    handle:close()
    
    clipboard_content = M.clean_escape_sequences(clipboard_content)
    
    local chan = vim.bo[buffer].channel
    if chan and chan > 0 then
      vim.fn.chansend(chan, clipboard_content)
    end
  end
  
  -- Map both Cmd+V and Ctrl+V
  vim.keymap.set("t", "<D-v>", claude_paste, { 
    buffer = buffer, 
    desc = "Paste in Claude Code (cleaned)" 
  })
  
  vim.keymap.set("t", "<C-v>", claude_paste, { 
    buffer = buffer, 
    desc = "Paste in Claude Code (cleaned)" 
  })
end

-- Initialize all paste fixes
function M.setup()
  -- Basic vim options
  vim.opt.clipboard = "unnamedplus"
  vim.opt.paste = false
  
  -- Setup all components
  M.disable_bracketed_paste_codes()
  M.disable_ghostty_bracketed_paste()
  M.setup_clipboard()
  M.setup_autocmds()
end

return M