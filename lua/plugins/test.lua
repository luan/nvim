vim.g.ultest_use_pty = 1

if os.getenv('TMUX') ~= '' then
  vim.g['test#strategy'] = 'vimux'
end
