" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/luan/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/luan/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/luan/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/luan/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/luan/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["TrueZen.nvim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins/truezen\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  ["auto-session"] = {
    config = { "\27LJ\1\2:\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/auto-session"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/bufdelete.nvim"
  },
  ["dashboard-nvim"] = {
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.dashboard\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.fzf\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/luan/.local/share/nvim/site/pack/packer/opt/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.gitsigns\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["go.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/go.nvim"
  },
  ["incsearch.vim"] = {
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.incsearch\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/incsearch.vim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\1\2Ç\2\0\0\2\0\n\0\0214\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0003\1\5\0:\1\4\0004\0\0\0007\0\1\0003\1\a\0:\1\6\0004\0\0\0007\0\1\0)\1\1\0:\1\b\0004\0\0\0007\0\1\0)\1\1\0:\1\t\0G\0\1\0-indent_blankline_show_first_indent_level4indent_blankline_show_trailing_blankline_indent\1\2\0\0\rterminal%indent_blankline_buftype_exclude\1\5\0\0\thelp\rterminal\14dashboard\vnofile&indent_blankline_filetype_exclude\bâ–\26indent_blankline_char\6g\bvim\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  kommentary = {
    config = { "\27LJ\1\2|\0\0\3\0\5\0\b4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0003\2\4\0>\0\3\1G\0\1\0\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\22kommentary.config\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lir.nvim"] = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.lir\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/lir.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\1\0028\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lspsaga\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lualine\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["mkdir.nvim"] = {
    config = { "\27LJ\1\2%\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\nmkdir\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/mkdir.nvim"
  },
  neon = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/neon"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-base16"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\1\2-\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\18plugins.compe\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-spectre"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-spectre"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.treesitter\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.trouble\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  undotree = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-closer"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-exchange"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-fetch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-grepper"] = {
    config = { "\27LJ\1\2¢\1\0\0\3\0\6\0\a4\0\0\0007\0\1\0003\1\4\0003\2\3\0:\2\5\1:\1\2\0G\0\1\0\ntools\1\0\4\24prompt_mapping_side\n<F12>\24prompt_mapping_tool\n<F10>\18simple_prompt\3\0\23prompt_mapping_dir\n<F11>\1\3\0\0\arg\bgit\fgrepper\6g\bvim\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-grepper"
  },
  ["vim-move"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-move"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-stay"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-stay"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-swap"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-swap"
  },
  ["vim-trailing-whitespace"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-trailing-whitespace"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\1\2;\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/luan/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: fzf.vim
time([[Setup for fzf.vim]], true)
try_loadstring("\27LJ\1\0028\0\0\2\0\4\0\0054\0\0\0007\0\1\0%\1\3\0:\1\2\0G\0\1\0\bFZF\23fzf_command_prefix\6g\bvim\0", "setup", "fzf.vim")
time([[Setup for fzf.vim]], false)
time([[packadd for fzf.vim]], true)
vim.cmd [[packadd fzf.vim]]
time([[packadd for fzf.vim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\1\2:\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\1\2;\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\1\2Ç\2\0\0\2\0\n\0\0214\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0003\1\5\0:\1\4\0004\0\0\0007\0\1\0003\1\a\0:\1\6\0004\0\0\0007\0\1\0)\1\1\0:\1\b\0004\0\0\0007\0\1\0)\1\1\0:\1\t\0G\0\1\0-indent_blankline_show_first_indent_level4indent_blankline_show_trailing_blankline_indent\1\2\0\0\rterminal%indent_blankline_buftype_exclude\1\5\0\0\thelp\rterminal\14dashboard\vnofile&indent_blankline_filetype_exclude\bâ–\26indent_blankline_char\6g\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
try_loadstring("\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.fzf\frequire\0", "config", "fzf.vim")
time([[Config for fzf.vim]], false)
-- Config for: incsearch.vim
time([[Config for incsearch.vim]], true)
try_loadstring("\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.incsearch\frequire\0", "config", "incsearch.vim")
time([[Config for incsearch.vim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.trouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
try_loadstring("\27LJ\1\2|\0\0\3\0\5\0\b4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0003\2\4\0>\0\3\1G\0\1\0\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\22kommentary.config\frequire\0", "config", "kommentary")
time([[Config for kommentary]], false)
-- Config for: TrueZen.nvim
time([[Config for TrueZen.nvim]], true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins/truezen\frequire\0", "config", "TrueZen.nvim")
time([[Config for TrueZen.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
try_loadstring("\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.dashboard\frequire\0", "config", "dashboard-nvim")
time([[Config for dashboard-nvim]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\1\2-\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\18plugins.compe\frequire\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\1\0028\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: vim-grepper
time([[Config for vim-grepper]], true)
try_loadstring("\27LJ\1\2¢\1\0\0\3\0\6\0\a4\0\0\0007\0\1\0003\1\4\0003\2\3\0:\2\5\1:\1\2\0G\0\1\0\ntools\1\0\4\24prompt_mapping_side\n<F12>\24prompt_mapping_tool\n<F10>\18simple_prompt\3\0\23prompt_mapping_dir\n<F11>\1\3\0\0\arg\bgit\fgrepper\6g\bvim\0", "config", "vim-grepper")
time([[Config for vim-grepper]], false)
-- Config for: lir.nvim
time([[Config for lir.nvim]], true)
try_loadstring("\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.lir\frequire\0", "config", "lir.nvim")
time([[Config for lir.nvim]], false)
-- Config for: mkdir.nvim
time([[Config for mkdir.nvim]], true)
try_loadstring("\27LJ\1\2%\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\nmkdir\frequire\0", "config", "mkdir.nvim")
time([[Config for mkdir.nvim]], false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
