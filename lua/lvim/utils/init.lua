local M = {}

function M.get_session_name()
  local name = vim.fn.getcwd()
  local branch = vim.fn.system "git branch --show-current"
  if vim.v.shell_error == 0 then
    return name .. branch
  else
    return name
  end
end

function M.is_executable(bin)
  return vim.fn.executable(bin) > 0
end

function M.current_path(buffer, opts)
  if buffer == nil then
    buffer = "%"
  end
  if opts == nil then
    opts = {}
  end
  if opts.absolute then
    return vim.fn.expand(buffer)
  end

  return vim.fn.fnamemodify(vim.fn.expand(buffer), ":~:.")
end

function M.save(opts)
  if not opts then
    opts = {}
  end

  if vim.api.nvim_eval [[&buftype]] ~= "" then
    return nil
  end

  if opts.skip_unmodified and vim.api.nvim_eval [[&modified]] ~= 1 then
    return nil
  end

  vim.schedule(function()
    vim.cmd "silent! write"

    local path = M.current_path("%:p", { absolute = true })
    if string.find(path, CONFIG_PATH) and string.match(path, "^lua/") then
      reload "config"
      local mod = path:gsub(CONFIG_PATH, ""):gsub("^/?lua/", ""):gsub("%.lua$", ""):gsub("/init$", "")
      reload(mod)
    end
  end)
end

function M.get_win_type(winid)
  winid = winid or vim.api.nvim_get_current_win()
  local info = vim.fn.getwininfo(winid)[1]
  if info.quickfix == 0 then
    return ""
  elseif info.loclist == 0 then
    return "c"
  else
    return "l"
  end
end

function M.get_win_info(qftype)
  local ll = qftype == "l" and 1 or 0
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.quickfix == 1 and info.loclist == ll then
      return info
    end
  end
  return nil
end

function M.toggle_quickfix()
  if M.get_win_info "c" ~= nil then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end

function M.toggle_loc()
  if M.get_win_info "l" ~= nil then
    vim.cmd.lclose()
  else
    vim.cmd.lopen()
  end
end

return M
