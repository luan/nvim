local M = {}
local Log = require "core.log"

function M.config()
  luanvim.builtin.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
      auto_reload_on_write = false,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      ignore_buffer_on_setup = false,
      open_on_setup = false,
      open_on_setup_file = false,
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = true,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = "disable",
      remove_keymaps = false,
      select_prompts = false,
      view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          custom_only = false,
          list = {},
        },
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_label = ":t",
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          webdev_colors = luanvim.use_icons,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = luanvim.use_icons,
            folder = luanvim.use_icons,
            folder_arrow = luanvim.use_icons,
            git = luanvim.use_icons,
          },
          glyphs = {
            default = luanvim.icons.ui.Text,
            symlink = luanvim.icons.ui.FileSymlink,
            bookmark = luanvim.icons.ui.BookMark,
            folder = {
              arrow_closed = luanvim.icons.ui.TriangleShortArrowRight,
              arrow_open = luanvim.icons.ui.TriangleShortArrowDown,
              default = luanvim.icons.ui.Folder,
              open = luanvim.icons.ui.FolderOpen,
              empty = luanvim.icons.ui.EmptyFolder,
              empty_open = luanvim.icons.ui.EmptyFolderOpen,
              symlink = luanvim.icons.ui.FolderSymlink,
              symlink_open = luanvim.icons.ui.FolderOpen,
            },
            git = {
              unstaged = luanvim.icons.git.FileUnstaged,
              staged = luanvim.icons.git.FileStaged,
              unmerged = luanvim.icons.git.FileUnmerged,
              renamed = luanvim.icons.git.FileRenamed,
              untracked = luanvim.icons.git.FileUntracked,
              deleted = luanvim.icons.git.FileDeleted,
              ignored = luanvim.icons.git.FileIgnored,
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = false,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        debounce_delay = 15,
        update_root = true,
        ignore_list = {},
      },
      ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
      },
      diagnostics = {
        enable = luanvim.use_icons,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = luanvim.icons.diagnostics.BoldHint,
          info = luanvim.icons.diagnostics.BoldInformation,
          warning = luanvim.icons.diagnostics.BoldWarning,
          error = luanvim.icons.diagnostics.BoldError,
        },
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { "node_modules", "\\.cache" },
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 200,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
      system_open = {
        cmd = nil,
        args = {},
      },
    },
  }
end

function M.start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

function M.setup()
	local status_ok, nvim_tree = pcall(require, "nvim-tree")
	if not status_ok then
	  Log:error "Failed to load nvim-tree"
	  return
	end

	if luanvim.builtin.nvimtree._setup_called then
	  Log:debug "ignoring repeated setup call for nvim-tree, see kyazdani42/nvim-tree.lua#1308"
	  return
	end

	luanvim.builtin.nvimtree._setup_called = true

	-- Implicitly update nvim-tree when project module is active
	if luanvim.builtin.project.active then
	  luanvim.builtin.nvimtree.setup.respect_buf_cwd = true
	  luanvim.builtin.nvimtree.setup.update_cwd = true
	  luanvim.builtin.nvimtree.setup.update_focused_file = { enable = true, update_cwd = true }
	end

	local function telescope_find_files(_)
	  require("core.nvim-tree").start_telescope "find_files"
	end

	local function telescope_live_grep(_)
	  require("core.nvim-tree").start_telescope "live_grep"
	end

	-- Add useful keymaps
	if #luanvim.builtin.nvimtree.setup.view.mappings.list == 0 then
	  luanvim.builtin.nvimtree.setup.view.mappings.list = {
	    { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
	    { key = "h", action = "close_node" },
	    { key = "v", action = "vsplit" },
	    { key = "C", action = "cd" },
	    { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
	    { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
	  }
	end

	nvim_tree.setup(luanvim.builtin.nvimtree.setup)

	if luanvim.builtin.nvimtree.on_config_done then
	  luanvim.builtin.nvimtree.on_config_done(nvim_tree)
	end
end

return M
