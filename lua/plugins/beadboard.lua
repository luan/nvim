local cached = ""

local function refresh()
  require("beadboard.cli").run({ "status" }, function(err, data)
    if err or not data or not data.summary then
      cached = ""
      return
    end
    local s = data.summary
    local open = s.open_issues or 0
    local wip = s.in_progress_issues or 0
    if open == 0 and wip == 0 then
      cached = ""
      return
    end
    local parts = {}
    if open > 0 then parts[#parts + 1] = open .. " open" end
    if wip > 0 then parts[#parts + 1] = wip .. " wip" end
    cached = table.concat(parts, ", ")
  end)
end

return {
  {
    "jfmyers9/beadboard",
    keys = {
      { "<leader>gk", "<cmd>Beadboard<cr>", desc = "Beadboard" },
    },
    config = function()
      require("beadboard").setup()
      refresh()
      vim.uv.new_timer():start(30000, 30000, vim.schedule_wrap(refresh))
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, {
        function() return cached end,
        icon = "◆",
        cond = function() return cached ~= "" end,
      })
    end,
  },
}
