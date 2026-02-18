local plans_dir = vim.fn.expand("~/.claude/plans")

local function ck_plans(opts)
  local cmd = "ck plan list --json"
  if opts and opts.archived then
    cmd = cmd .. " --archived"
  end
  local output = vim.fn.system(cmd .. " 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    return {}
  end
  local ok, plans = pcall(vim.json.decode, output)
  if not ok or type(plans) ~= "table" then
    return {}
  end
  return plans
end

local function plan_path(name)
  return plans_dir .. "/" .. name .. ".md"
end

return {
  "folke/snacks.nvim",
  keys = {
    -- Pick from project plans
    {
      "<leader>kp",
      function()
        local plans = ck_plans()
        if #plans == 0 then
          vim.notify("No plans for this project", vim.log.levels.INFO)
          return
        end

        local items = {}
        for i, p in ipairs(plans) do
          local label = p.title ~= "" and p.title or p.name
          table.insert(items, {
            idx = i,
            text = string.format("%s  %s  %s", label, p.modified, p.size),
            file = plan_path(p.name),
          })
        end

        Snacks.picker({
          title = "Plans",
          items = items,
          format = function(item, _)
            return {
              { item.text, "String" },
            }
          end,
          confirm = function(picker, item)
            picker:close()
            vim.cmd("edit " .. vim.fn.fnameescape(item.file))
          end,
        })
      end,
      desc = "Plans",
    },
    -- Pick from archived plans
    {
      "<leader>kP",
      function()
        local plans = ck_plans({ archived = true })
        if #plans == 0 then
          vim.notify("No archived plans for this project", vim.log.levels.INFO)
          return
        end

        local items = {}
        for i, p in ipairs(plans) do
          local label = p.title ~= "" and p.title or p.name
          table.insert(items, {
            idx = i,
            text = string.format("%s  %s  %s", label, p.modified, p.size),
            file = plan_path(p.name),
          })
        end

        Snacks.picker({
          title = "Archived Plans",
          items = items,
          format = function(item, _)
            return {
              { item.text, "String" },
            }
          end,
          confirm = function(picker, item)
            picker:close()
            vim.cmd("edit " .. vim.fn.fnameescape(item.file))
          end,
        })
      end,
      desc = "Archived plans",
    },
    -- Open most recent plan
    {
      "<leader>kr",
      function()
        local output = vim.fn.system("ck plan latest 2>/dev/null")
        if vim.v.shell_error ~= 0 then
          vim.notify("No plans for this project", vim.log.levels.INFO)
          return
        end
        local path = vim.trim(output)
        if path ~= "" then
          vim.cmd("edit " .. vim.fn.fnameescape(path))
        end
      end,
      desc = "Recent plan",
    },
    -- Grep across plans
    {
      "<leader>kg",
      function()
        if vim.fn.isdirectory(plans_dir) == 0 then
          vim.notify("No plans directory", vim.log.levels.INFO)
          return
        end
        Snacks.picker.grep({ cwd = plans_dir })
      end,
      desc = "Grep plans",
    },
    -- Copy plan paths as @-refs
    {
      "<leader>kc",
      function()
        local plans = ck_plans()
        if #plans == 0 then
          vim.notify("No plans for this project", vim.log.levels.INFO)
          return
        end

        local items = {}
        for i, p in ipairs(plans) do
          table.insert(items, {
            idx = i,
            text = p.title ~= "" and p.title or p.name,
            file = plan_path(p.name),
          })
        end

        Snacks.picker({
          title = "Copy plan context",
          items = items,
          format = function(item, _)
            return {
              { item.text, "String" },
            }
          end,
          confirm = function(picker, items)
            picker:close()
            local sel = type(items) == "table" and items or { items }
            local refs = {}
            for _, item in ipairs(sel) do
              if item.file then
                table.insert(refs, "@" .. item.file)
              end
            end
            if #refs > 0 then
              vim.fn.setreg("+", table.concat(refs, " "))
              vim.notify("Copied " .. #refs .. " plan refs to clipboard")
            end
          end,
          win = {
            input = {
              keys = {
                ["<Tab>"] = { "select_and_next", mode = { "n", "i" } },
              },
            },
          },
        })
      end,
      desc = "Copy plan context",
    },
  },
}
