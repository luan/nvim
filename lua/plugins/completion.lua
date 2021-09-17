vim.g.closer_no_mappings = 1
vim.g.endwise_no_mappings = 1

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local t = require('utils').t

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping(function(fallback)
      if not cmp.confirm({ select = false }) then
	fallback()
	vim.fn.feedkeys(t('<Plug>DiscretionaryEnd'), '')
	vim.fn.feedkeys(t('<Plug>CloserClose'), '')
      end
    end),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
	vim.fn.feedkeys(t('<C-n>'), 'n')
      elseif check_back_space() then
	vim.fn.feedkeys(t('<Tab>'), 'n')
      elseif vim.fn['vsnip#available']() == 1 then
	vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
      else
	fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
	vim.fn.feedkeys(t('<C-p>'), 'n')
      elseif check_back_space() then
	vim.fn.feedkeys(t('<S-Tab>'), 'n')
      elseif vim.fn['vsnip#available']() == 1 then
	vim.fn.feedkeys(t('<Plug>(vsnip-prev)'), '')
      else
	fallback()
      end
    end, {'i', 's'}),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if vim.fn['vsnip#available']() == 1 then
	vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
      else
	fallback()
      end
    end, {'i', 's'}),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if vim.fn['vsnip#available']() == 1 then
	vim.fn.feedkeys(t('<Plug>(vsnip-prev-or-jump)'), '')
      else
	fallback()
      end
    end, {'i', 's'}),
  },
  sources = {
    {name = 'buffer'},
    {name = 'vsnip'},
    {name = 'calc'},
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
  },
})
