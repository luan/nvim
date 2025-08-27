return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    cmake_runner = {
      name = "terminal",
      default_opts = {
        cwd = function()
          -- Always run from the project root instead of build directory
          return vim.fn.getcwd()
        end,
      },
    },
    cmake_executor = {
      name = "terminal",
      default_opts = {
        cwd = function()
          -- Always run from the project root instead of build directory
          return vim.fn.getcwd()
        end,
      },
    },
  },
}

