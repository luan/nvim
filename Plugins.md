# Plug-ins

This lists, justifies and briefly documents each plug-in included in this
distribution. Separating them in categories. You can find full documentation on
the plug-in's github page or by accessing its help (usually at `:h
<plugin-name>`). Most user configuration should be put in your `user/after.vim`
unless otherwise stated on the docs for the plug-in or here.

## Color schemes

These merely add color schemes (a.k.a. themes) for us to chose from. We'll have
a default configured on `colorscheme.vim` but users can easily swap them on
their local configurations.

### [`flazz/vim-colorschemes`](https://github.com/flazz/vim-colorschemes)

A large package of color schemes for you to chose from.
[List](https://github.com/flazz/vim-colorschemes/tree/master/colors).

### [`rafi/awesome-vim-colorschemes`](https://github.com/rafi/awesome-vim-colorschemes)

Another package of color schemes, slightly better documented on its
[README](https://github.com/rafi/awesome-vim-colorschemes/tree/master/README.md).

### [`chriskempson/base16-vim`](https://github.com/chriskempson/base16-vim)

A great collection of schemes ported as 16 color palettes for great portability.

### [`joshdick/onedark.vim`](https://github.com/joshdick/onedark.vim)

Atom's text editor color scheme ported to vim (currently the default scheme of
the distribution).

## UI - User interface additions

Plug-ins that add UI elements, these should require no to little interaction to
activate and are ideally disable-able.

### [`mhinz/vim-startify`](https://github.com/mhinz/vim-startify)

A better start page for vim. Customized to show the current version and most
recently used files in the current directory. Our local configuration for it
lives in [include/startify.vim](include/startify.vim). This can be disabled with
the following snippet:

```vim
let g:startify_disable_at_vimenter = 0
```

### [`blueyed/vim-diminactive`](https://github.com/blueyed/vim-diminactive)

Dim inactive window to make it more obvious where the focus is. This can be
disabled with the following snippet:

```vim
autocmd VimEnter * :DimInactiveOff
```

### [`bronson/vim-trailing-whitespace`](https://github.com/bronson/vim-trailing-whitespace)

Show trailing whitespace in red. Can only be disabled by preventing loading of
the plug-in. This needs to go on your `user/before.vim`:

```vim
let g:loaded_trailing_whitespace_plugin = 1
```

### [`kshenoy/vim-signature`](https://github.com/kshenoy/vim-signature)

Shows marks on the gutter. Disable with:

```vim
let g:SignatureEnabledAtStartup = 0
```

### [`itchyny/lightline.vim`](https://github.com/itchyny/lightline.vim)

Fast, simple and lightweight status line. Requires a
[powerline](https://github.com/powerline/fonts) patched font to show properly.
Our local configuration for it
lives in [include/lightline.vim](include/lightline.vim). This can be disabled with
the following snippet:

```vim
let g:lightline.enable = {
  \ 'statusline': 0,
  \ 'tabline': 0
  \ }
" You may also want to enable showmode again to see -- INSERT --/etc
set showmode
```

You can also change it's colorscheme, and enable tabline!

```vim
let g:lightline.colorscheme = 'wombat'
let g:lightline.enable = {
      \ 'statusline': 1,
      \ 'tabline': 1
      \ }
```

More advanced configuration is documented in `:h lightline`

### [`hecal3/vim-leader-guide`](https://github.com/hecal3/vim-leader-guide)

Shows a guide to key mappings. This is meant to make our custom key mappings
more discoverable. Will automatically show when hitting the leader key. Disable
with:

```vim
unmap <leader>
```
