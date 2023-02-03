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
    if opts.format ~= false and vim.lsp.buf.server_ready() then
      vim.lsp.buf.format {
        timeout_ms = 5000,
        filter = function(client)
          return client.name ~= "tsserver"
        end,
      }
    end
    vim.cmd "silent! write"

    local path = M.current_path("%:p", { absolute = true })
    if string.find(path, CONFIG_PATH) and string.match(path, "^lua/") then
      reload "config"
      local mod = path:gsub(CONFIG_PATH, ""):gsub("^/?lua/", ""):gsub("%.lua$", ""):gsub("/init$", "")
      reload(mod)
    end
  end)
end

return M
