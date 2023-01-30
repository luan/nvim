local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
  return
end

require("spectre").setup {
  color_devicons = true,
  open_cmd = "lua reload('lvim.utils.floating-window').new()",
  live_update = true, -- auto excute search again when you write any file in vim
  line_sep_start = "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
  result_padding = "┃  ",
  line_sep = "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
  replace_vim_cmd = "cdo",
  is_open_target_win = true, --open file on opener window
  is_insert_mode = true, -- start open panel on is_insert_mode
}
