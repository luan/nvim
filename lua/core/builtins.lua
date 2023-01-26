local M = {}

local builtins = {
  "config.nvim-tree",
  "config.project",
  "config.mason",
}

function M.config(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = reload(builtin_path)

    builtin.config(config)
  end
end

return M

