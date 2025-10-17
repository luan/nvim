return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Configure linters by filetype
      lint.linters_by_ft = {
        swift = { "swiftlint" },
        go = { "golangcilint" },
      }

      lint.linters.swiftlint = function()
        local pattern = "[^:]+:(%d+):(%d+): (%w+): (.+)"
        local groups = { "lnum", "col", "severity", "message" }
        local defaults = { ["source"] = "swiftlint" }
        local severity_map = {
          ["error"] = vim.diagnostic.severity.ERROR,
          ["warning"] = vim.diagnostic.severity.WARN,
        }

        return {
          cmd = "swiftlint",
          stdin = false,
          args = { "lint" },
          stream = "stdout",
          ignore_exitcode = true,
          parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults),
        }
      end

      -- Create autocmd group for linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      -- Set up autocmds to trigger linting
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          -- Only lint if the file is not too large
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
          if ok and stats and stats.size > max_filesize then
            return
          end

          -- Trigger linting
          lint.try_lint()
        end,
      })

      -- Optional: Add a command to manually trigger linting
      vim.api.nvim_create_user_command("Lint", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current buffer" })
    end,
  },
}
