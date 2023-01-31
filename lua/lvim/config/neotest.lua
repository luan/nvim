require("neotest").setup {
  strategy = "neotest",
  consumers = {
    overseer = require "neotest.consumers.overseer",
  },
  adapters = {
    require "neotest-python",
    require "neotest-plenary",
    require "neotest-go",
    -- require "neotest-jest",
    require "neotest-vitest",
    require "neotest-rust",
    require "neotest-vim-test" {
      ignore_file_types = {
        "python",
        "vim",
        "lua",
        "go",
        "ts",
        "js",
        "rust",
      },
    },
  },
}
