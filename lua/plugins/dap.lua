return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
      local dap = require("dap")
      dap.defaults.fallback.exception_breakpoints = {}
    end,
  },
  {
    "lucaSartore/nvim-dap-exception-breakpoints",
    dependencies = { "mfussenegger/nvim-dap" },

    config = function()
      local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")

      vim.api.nvim_set_keymap(
        "n",
        "<leader>dE",
        "",
        { desc = "[D]ebug [C]ondition breakpoints", callback = set_exception_breakpoints }
      )
    end,
  },
  -- {
  --   "julianolf/nvim-dap-lldb",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   opts = { codelldb_path = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap" },
  -- },
}
