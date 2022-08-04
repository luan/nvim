if vim.fn.executable('fd') == 1 then
  vim.env.FZF_DEFAULT_COMMAND = 'fd --hidden --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --type f'
elseif vim.fn.executable('rg') == 1 then
  vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*"'
elseif vim.fn.executable('ag') == 1 then
  vim.env.FZF_DEFAULT_COMMAND = 'ag -g ""'
end

vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

vim.g.fzf_colors = {
  ['fg'] = { 'fg', 'Normal' },
  ['bg'] = { 'bg', 'Normal' },
  ['hl'] = { 'fg', 'Comment' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
  ['hl+'] = { 'fg', 'Statement' },
  ['info'] = { 'fg', 'PreProc' },
  ['border'] = { 'fg', 'Ignore' },
  ['prompt'] = { 'fg', 'Conditional' },
  ['pointer'] = { 'fg', 'Exception' },
  ['marker'] = { 'fg', 'Keyword' },
  ['spinner'] = { 'fg', 'Label' },
  ['header'] = { 'fg', 'Comment' },
}

vim.g.fzf_history_dir = '~/.local/share/fzf-history'
