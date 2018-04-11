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

![vim-startify](https://raw.githubusercontent.com/mhinz/vim-startify/master/images/startify-logo.png)

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

![vim-signature](https://github.com/kshenoy/vim-signature/raw/images/screens/vim-signature_mark_jumps.gif?raw=true)

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

![lightline](https://raw.githubusercontent.com/wiki/itchyny/lightline.vim/image/powerline.png)

### [`hecal3/vim-leader-guide`](https://github.com/hecal3/vim-leader-guide)

Shows a guide to key mappings. This is meant to make our custom key mappings
more discoverable. Will automatically show when hitting the leader key. Disable
with:

```vim
unmap <leader>
```

![vim-leader-guide](https://cloud.githubusercontent.com/assets/11238697/14471215/bbc54a40-00ed-11e6-9eb2-8b6fb247589f.png)

## Editing - Text manipulation

Plug-ins providing commands or helpers that directly impact how you edit text
passively or actively.

### [`tpope/vim-commentary`](https://github.com/tpope/vim-commentary)

(Un-)comment code. Default binding is the operator `gc`, allowing you to do
`gc<motion>`, see documentation for more details. We have a local binding at
`<c-_>` (or Control-/) to toggle comments on the current line or
visual selection.

### [`terryma/vim-multiple-cursors`](https://github.com/terryma/vim-multiple-cursors)

Provides multiple cursor functionality like the one in Atom or Sublime. Activate
with `<c-n>` in either normal or visual mode for current word or selection
respectively. Then:

* `<c-n>`: find next occurrence and create cursor
* `<c-p>`: go back to previous cursor (removing current)
* `<c-x>`: skip current occurrence. Like `<c-n>` but without creating a cursor
  for the current.

Or use `:MultipleCursorsFind` to create cursors from a search.

### [`pelodelfuego/vim-swoop`](https://github.com/pelodelfuego/vim-swoop)

Visual context when bulk editing buffers. Start with `:Swoop` for current buffer
only or `:Swoop!` for all open buffers. First line in the newly opened window is
a search pattern (that can also be passed as argument to the `:Swoop[!]`
commands). Editing on the swoop buffer will propagate to the real files
automatically.

### [`terryma/vim-expand-region`](https://github.com/terryma/vim-expand-region)

Select regions incrementally. Simply hit `+` to expand your selection or `_` to
reduce it.

### [`dropofwill/auto-pairs`](https://github.com/dropofwill/auto-pairs)

Automatically close pairs such as () or [] on insert mode. While on insert mode:

* `<a-p>`: toggles auto-pairs no or off
* `<a-n>`: jumps out of the current pair

You can completely disable the plug-in with the following snipped on your
`before.vim`:

```vim
let g:AutoPairsLoaded = 1
```

### [`tpope/vim-endwise`](https://github.com/tpope/vim-endwise)

Automatically add 'end' when opening a block.

### [`machakann/vim-swap`](https://github.com/machakann/vim-swap)

Move parameters around (delimited by a separator such as ,). `gs` To enter
"swap-mode" or `g>`/`g<` to move parameters around in normal mode.

### [`AndrewRadev/splitjoin.vim`](https://github.com/AndrewRadev/splitjoin.vim)

Simplifies the transition between multi-line and single-line code. `gS` splits
and `gJ` joins.

### [`sk1418/Join`](https://github.com/sk1418/Join)

`:Join` command. Allows you to join lines with a separator, for example `:J ',
'` will join lines with a `, ` in between them.

### [`tpope/vim-surround`](https://github.com/tpope/vim-surround)

Quoting/parenthesizing made simple; e.g. ysiw) to wrap word in parens.

### [`tpope/vim-repeat`](https://github.com/tpope/vim-repeat)

Enable repeating supported plug-in maps with [`.`](https://github.com/.)

### [`maxbrunsfeld/vim-emacs-bindings`](https://github.com/maxbrunsfeld/vim-emacs-bindings)

Add emacs/bash/cocoa key bindings to vim, in insert and command-line modes.

### [`matze/vim-move`](https://github.com/matze/vim-move)

Plugin to move lines and selections up and down. `<a-k>`/`<a-j>`.

### [`junegunn/vim-easy-align`](https://github.com/junegunn/vim-easy-align)

A Vim alignment plug-in. See readme for examples. `ga` gets you in "align mode".

### [`tpope/vim-speeddating`](https://github.com/tpope/vim-speeddating)

Use CTRL-A/CTRL-X to increment dates, times, and more.

### [`tommcdo/vim-exchange`](https://github.com/tommcdo/vim-exchange)

Easy text exchange operator for Vim. `cx<motion>` in normal mode or `X` in
visual mode. Running again after making a selection (which will be visually
highlighted) will swap the two regions.

