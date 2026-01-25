return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        backend = "zellij",
        enabled = true,
      },
      tools = {
        opencode = {
          cmd = { "opencode" },
          url = "https://github.com/sst/opencode",
        },
      },
      win = {
        layout = "right",
        split = {
          width = 100,
        },
        keys = {
          hide_n = { "q", "hide", mode = "n" }, -- hide from normal mode
          hide_t = { "<c-q>", "hide" }, -- hide from terminal mode
          win_p = { "<c-w>p", "blur" }, -- leave the cli window
          blur = { "<m-o>", "blur" }, -- leave the cli window
          prompt = { "<m-p>", "prompt" }, -- insert prompt or context
        },
      },
    },
  },
  keys = {
    {
      "<M-[>90;9",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
      mode = { "n", "v", "i", "t" },
    },
  },
}
