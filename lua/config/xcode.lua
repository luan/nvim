local map = vim.keymap.set

map("n", "<M-x>", function()
  local file_path = vim.fn.expand("%:p")
  if file_path ~= "" then
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    vim.fn.system({ "xed", "-l", tostring(line), tostring(col), file_path })
  else
    vim.notify("No file to open", vim.log.levels.WARN)
  end
end, { desc = "Open current file in Xcode" })

map("n", "<leader><M-x>", function()
  local cwd = vim.fn.getcwd()
  local workspaces = {}

  -- Find all .xcworkspace directories
  for _, item in ipairs(vim.fn.readdir(cwd)) do
    local path = cwd .. "/" .. item
    if vim.fn.isdirectory(path) == 1 and item:match("%.xcworkspace$") then
      table.insert(workspaces, path)
    end
  end

  if #workspaces == 0 then
    vim.notify("No .xcworkspace directories found in current directory", vim.log.levels.WARN)
    return
  elseif #workspaces == 1 then
    vim.fn.system({ "open", workspaces[1] })
    vim.notify("Opened " .. vim.fn.fnamemodify(workspaces[1], ":t"))
  else
    local items = {}
    for i, workspace in ipairs(workspaces) do
      table.insert(items, {
        idx = i,
        text = vim.fn.fnamemodify(workspace, ":t"),
        path = workspace,
      })
    end

    Snacks.picker({
      title = "Select Xcode Workspace",
      layout = {
        preview = false,
        width = 0.4,
        height = 0.3,
      },
      items = items,
      format = function(item, _)
        return {
          { item.text, "String" },
        }
      end,
      confirm = function(picker, item)
        picker:close()
        vim.fn.system({ "open", item.path })
        vim.notify("Opened " .. item.text)
      end,
    })
  end
end, { desc = "Open Xcode workspace" })
