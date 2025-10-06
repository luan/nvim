return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        backend = "zellij",
        enabled = false,
      },
      tools = {
        zai = { cmd = { "zai" }, url = "https://github.com/anthropics/claude-code" },
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
      "<D-i>",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
      mode = { "n", "v", "i", "t" },
    },
  },
}
