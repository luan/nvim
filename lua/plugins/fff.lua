local function cwd(opts)
  opts = opts or {}
  return opts.cwd or (opts.root == false and (vim.uv or vim.loop).cwd() or LazyVim.root({ buf = opts.buf }))
end

local function visual_selection()
  local ok, region = pcall(vim.fn.getregion, vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  if ok and region and #region > 0 then
    return table.concat(region, "\n")
  end
  return nil
end

local function grep_query(command)
  local mode = vim.fn.mode()
  if command == "grep_visual" or (command == "grep_word" and (mode == "v" or mode == "V" or mode == "\22")) then
    return visual_selection()
  end
  return vim.fn.expand("<cword>")
end

local function fff_opts(opts)
  opts = opts or {}
  return vim.tbl_deep_extend("force", opts, {
    cwd = cwd(opts),
  })
end

local function rescan_if_initialized()
  local core = package.loaded["fff.core"]
  if not core or not core.is_file_picker_initialized or not core.is_file_picker_initialized() then
    return
  end

  pcall(function()
    require("fff").scan_files()
  end)
end

local function install_refresh_autocmd()
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("fff_refresh_on_write", { clear = true }),
    desc = "Refresh FFF's content index after saving a file",
    callback = function(args)
      if args.file == "" or vim.bo[args.buf].buftype ~= "" then
        return
      end
      rescan_if_initialized()
    end,
  })
end

local function install_lazyvim_picker()
  if not LazyVim or not LazyVim.pick then
    return
  end

  local previous = LazyVim.pick.picker
  if previous and previous.name == "fff" then
    return
  end

  LazyVim.pick.picker = {
    name = "fff",
    commands = {
      files = "files",
      git_files = "files",
      live_grep = "live_grep",
      grep = "live_grep",
      grep_word = "grep_word",
      grep_cword = "grep_word",
      grep_visual = "grep_visual",
    },
    open = function(command, opts)
      opts = opts or {}

      if command == "files" then
        rescan_if_initialized()
        return require("fff").find_files(fff_opts(opts))
      end

      if command == "live_grep" then
        rescan_if_initialized()
        return require("fff").live_grep(fff_opts(opts))
      end

      if command == "grep_word" or command == "grep_visual" then
        rescan_if_initialized()
        return require("fff").live_grep(vim.tbl_deep_extend("force", fff_opts(opts), {
          query = grep_query(command),
        }))
      end

      if previous then
        command = previous.commands[command] or command
        return previous.open(command, opts)
      end

      LazyVim.error("No picker available for `" .. command .. "`")
    end,
  }
end

return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    lazy = false,
    opts = {
      prompt = " ",
      title = "FFFiles",
      max_results = 100,
      lazy_sync = true,
      layout = {
        width = 0.8,
        height = 0.8,
        prompt_position = "top",
        preview_position = "right",
        preview_size = 0.5,
      },
      preview = {
        line_numbers = true,
      },
      keymaps = {
        close = "<Esc>",
        select = "<CR>",
        select_split = "<C-s>",
        select_vsplit = "<C-v>",
        select_tab = "<C-t>",
        move_up = { "<Up>", "<C-p>" },
        move_down = { "<Down>", "<C-n>" },
        preview_scroll_up = "<C-u>",
        preview_scroll_down = "<C-d>",
        cycle_grep_modes = "<S-Tab>",
        cycle_previous_query = "<C-Up>",
        toggle_select = "<Tab>",
        send_to_quickfix = "<C-q>",
      },
      grep = {
        smart_case = true,
        modes = { "plain", "regex", "fuzzy" },
      },
    },
    config = function(_, opts)
      require("fff").setup(opts)
      install_refresh_autocmd()
      install_lazyvim_picker()
    end,
    keys = {
      { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sw", LazyVim.pick("grep_word"), desc = "Word/Selection (Root Dir)", mode = { "n", "x" } },
      { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Word/Selection (cwd)", mode = { "n", "x" } },
    },
  },
}
