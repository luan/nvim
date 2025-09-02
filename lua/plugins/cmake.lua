local conf = {
  name = "overseer",
  opts = {
    new_task_opts = {
      strategy = {
        "toggleterm",
        direction = "horizontal",
        autos_croll = true,
        quit_on_exit = "success",
      },
    },
    on_new_task = function(task)
      task.cwd = vim.fn.getcwd()
    end,
  }, -- options to pass into the `overseer.new_task` command

  cwd = vim.fn.getcwd(),
}

local map = vim.keymap.set
local loaded = false

local function check()
  local cwd = vim.uv.cwd()
  if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
    map("n", "<leader>tc", "<cmd>CMakeRunTest<cr>", { desc = "Run CMake tests" })
    map("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "Run CMake build" })
    map("n", "<leader>cB", "<cmd>CMakeBuild!<cr>", { desc = "Run CMake build (clean)" })
    map("n", "<leader>cC", "<cmd>CMakeClean<cr>", { desc = "Run CMake clean" })
    map("n", "<leader>cP", "<cmd>CMakeSelectConfigurePreset<cr>", { desc = "Select CMake configure preset" })
    map("n", "<leader>dd", "<cmd>CMakeDebug<cr>", { desc = "Run CMake debug" })
    map("n", "<leader>dD", "<cmd>CMakeRun<cr>", { desc = "Run CMake run" })
    map("n", "<leader>dD", "<cmd>CMakeRun<cr>", { desc = "Run CMake run" })
    loaded = true
  end
end
check()
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    if not loaded then
      check()
    end
  end,
})

return {
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  {
    "Civitasv/cmake-tools.nvim",

    opts = {
      cmake_generate_options = { "-DBYPASS_CLIENT_VERSION_CHECK:BOOL=ON" },
      cmake_build_options = { "--parallel=24" },
      cmake_compile_commands_options = {
        action = "soft_link", -- available options: soft_link, copy, lsp, none
        -- soft_link: this will automatically make a soft link from compile commands file to target
        -- copy:      this will automatically copy compile commands file to target
        -- lsp:       this will automatically set compile commands file location using lsp
        -- none:      this will make this option ignored
        target = vim.loop.cwd(), -- path to directory, this is used only if action == "soft_link" or action == "copy"
      },

      cmake_dap_configuration = {
        cwd = vim.fn.getcwd(),
      },

      cmake_executor = { name = "quickfix" },
      cmake_runner = conf,
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "orjangj/neotest-ctest",
    },
    config = function()
      require("neotest-ctest").setup({
        frameworks = { "boostut" },
        filter_dir = function(name, rel_path, root)
          return name ~= "vcpkg_installed"
            and name ~= "build"
            and name ~= "out"
            and name ~= ".git"
            and name ~= "node_modules"
            and name ~= ".vscode"
            and not name:match("^%.")
        end,
      })

      require("neotest").setup({
        adapters = {
          require("neotest-ctest"),
        },
        status = { virtual_text = true },
        output = {
          open_on_run = true,
          enabled = true,
        },
        log_level = vim.log.levels.DEBUG,
        discovery = {
          enabled = true,
          concurrent = 1,
        },
      })
    end,
  },
}
