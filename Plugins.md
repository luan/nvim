<!-- vim: set foldmethod=marker -->

# Plug-ins

This lists, justifies and briefly documents each plug-in included in this
distribution. Separating them in categories. You can find full documentation on
the plug-in's github page or by accessing its help (usually at `:h
<plugin-name>`). Most user configuration should be put in your `user/after.vim`
unless otherwise stated on the docs for the plug-in or here.

Table of Contents
=================

<!--ts-->
   * [Plug-ins](#plug-ins)
   * [Table of Contents](#table-of-contents)
      * [Color schemes](#color-schemes)
         * [chriskempson/base16-vim](#chriskempsonbase16-vim)
         * [joshdick/onedark.vim](#joshdickonedarkvim)
      * [UI - User interface additions](#ui---user-interface-additions)
         * [mhinz/vim-startify](#mhinzvim-startify)
         * [bronson/vim-trailing-whitespace](#bronsonvim-trailing-whitespace)
         * [kshenoy/vim-signature](#kshenoyvim-signature)
         * [itchyny/lightline.vim](#itchynylightlinevim)
         * [hecal3/vim-leader-guide](#hecal3vim-leader-guide)
      * [Editing - Text manipulation](#editing---text-manipulation)
         * [tpope/vim-commentary](#tpopevim-commentary)
         * [terryma/vim-multiple-cursors](#terrymavim-multiple-cursors)
         * [pelodelfuego/vim-swoop](#pelodelfuegovim-swoop)
         * [terryma/vim-expand-region](#terrymavim-expand-region)
         * [dropofwill/auto-pairs](#dropofwillauto-pairs)
         * [tpope/vim-endwise](#tpopevim-endwise)
         * [machakann/vim-swap](#machakannvim-swap)
         * [AndrewRadev/splitjoin.vim](#andrewradevsplitjoinvim)
         * [sk1418/Join](#sk1418join)
         * [tpope/vim-surround](#tpopevim-surround)
         * [tpope/vim-repeat](#tpopevim-repeat)
         * [maxbrunsfeld/vim-emacs-bindings](#maxbrunsfeldvim-emacs-bindings)
         * [matze/vim-move](#matzevim-move)
         * [junegunn/vim-easy-align](#junegunnvim-easy-align)
         * [tpope/vim-speeddating](#tpopevim-speeddating)
         * [tommcdo/vim-exchange](#tommcdovim-exchange)
      * [General -- Helpful generic tools with no dependencies](#general----helpful-generic-tools-with-no-dependencies)
         * [tpope/vim-projectionist](#tpopevim-projectionist)
         * [tpope/vim-sleuth](#tpopevim-sleuth)
         * [tpope/vim-abolish](#tpopevim-abolish)
         * [tpope/vim-unimpaired](#tpopevim-unimpaired)
         * [tpope/vim-eunuch](#tpopevim-eunuch)
         * [kopischke/vim-stay](#kopischkevim-stay)
         * [kopischke/vim-fetch](#kopischkevim-fetch)
         * [mbbill/undotree](#mbbillundotree)
         * [Konfekt/FastFold](#konfektfastfold)
         * [mhinz/vim-sayonara](#mhinzvim-sayonara)
         * [junegunn/goyo.vim](#junegunngoyovim)
         * [junegunn/limelight.vim](#junegunnlimelightvim)
         * [benmills/vimux](#benmillsvimux)
         * [tpope/vim-dispatch](#tpopevim-dispatch)
         * [kassio/neoterm](#kassioneoterm)
         * [romainl/vim-qf](#romainlvim-qf)

<!-- Added by: luan, at: 2018-04-26T07:32-07:00 -->

<!--te-->

## Color schemes<!--{-->

These merely add color schemes (a.k.a. themes) for us to chose from. We'll have
a default configured on `colorscheme.vim` but users can easily swap them on
their local configurations.

### [`chriskempson/base16-vim`](https://github.com/chriskempson/base16-vim)

A great collection of schemes ported as 16 color palettes for great portability.

### [`joshdick/onedark.vim`](https://github.com/joshdick/onedark.vim)

Atom's text editor color scheme ported to vim (currently the default scheme of
the distribution).
<!--}-->

## UI - User interface additions<!--{-->

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

![vim-startify](https://github.com/mhinz/vim-startify/blob/master/images/startify-menu.png)

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
<!--}-->

## Editing - Text manipulation<!--{-->

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

![vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors/raw/master/assets/example1.gif?raw=true<Paste>)

### [`pelodelfuego/vim-swoop`](https://github.com/pelodelfuego/vim-swoop)

Visual context when bulk editing buffers. Start with `:Swoop` for current buffer
only or `:Swoop!` for all open buffers. First line in the newly opened window is
a search pattern (that can also be passed as argument to the `:Swoop[!]`
commands). Editing on the swoop buffer will propagate to the real files
automatically.

![vim-swoop](https://github.com/pelodelfuego/vim-swoop/raw/master/doc/images/moveSwoop.gif)

### [`terryma/vim-expand-region`](https://github.com/terryma/vim-expand-region)

Select regions incrementally. Simply hit `+` to expand your selection or `_` to
reduce it.

![vim-expand-region](https://camo.githubusercontent.com/64655fb5626161f9245df9b562ff8584fc61067f/68747470733a2f2f7261772e6769746875622e636f6d2f74657272796d612f76696d2d657870616e642d726567696f6e2f6d61737465722f657870616e642d726567696f6e2e676966)

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

![vim-swap](https://camo.githubusercontent.com/b8f954e6c61f74bc03da8251dffa95c16d393563/687474703a2f2f617274392e70686f746f7a6f752e6a702f7075622f3938362f333038303938362f70686f746f2f3233323836383939375f6f72672e76313435333831353530342e676966)

### [`AndrewRadev/splitjoin.vim`](https://github.com/AndrewRadev/splitjoin.vim)

Simplifies the transition between multi-line and single-line code. `gS` splits
and `gJ` joins.

![splitjoin.vim](https://camo.githubusercontent.com/ecc7cb0c04c764cffaf17a2b8e8c2fd0ddd57e90/687474703a2f2f692e616e6472657772616465762e636f6d2f64663163376238393536303233353264376365333132323139366333653664662e676966)

### [`sk1418/Join`](https://github.com/sk1418/Join)

`:Join` command. Allows you to join lines with a separator, for example `:J ',
'` will join lines with a `, ` in between them.

Before     |command & description                                                        |After
---        |---                                                                          |---
![][before]|`:J ', ' 3`<br/>Join with:<br/>`sep`<br/>`count`                             |![][after01]
![][before]|`:J '-' 3 r`<br/>Join with:<br/>`sep`<br/>`count`<br/>`reverse`              |![][after02]
![][before]|`:J '-' 3 k`<br/>Join with:<br/>`sep`<br/>`count`<br/>`keep`                 |![][after03]
![][before]|`:J '-' 3 kr`<br/>Join with:<br/>`sep`<br/>`count`<br/>`keep`<br/>`reverse`  |![][after04]
![][before]|`:J  -3`<br/>Join with:<br/>negative `count`                                 |![][after05]
![][before]|`:J -3 r`<br/>Join with:<br/>negative `count`<br/>`reverse`                  |![][after06]
![][before]|`:J -3 kr`<br/>Join with:<br/>negative `count`<br/>`reverse`<br/>`keep`      |![][after07]
![][before]|`:2,5J "'\"\t" k`<br/>Join with:<br/>`range`<br/>special `sep`<br/>`keep`    |![][after08]
![][before]|`:2,5J "# " rk`<br/>Join with:<br/>`range`<br/>`sep`<br/>`keep`<br/>`reverse`|![][after09]
![][before]|`:5,7J 3`<br/>Join with:<br/>`range`<br/>`count`                             |![][after10]
![][before]|`:5,7J -3`<br/>Join with:<br/>`range`<br/>negative `count`                   |![][after11]


[before]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_before.png
[after01]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_01after.png
[after02]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_02after.png
[after03]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_03after.png
[after04]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_04after.png
[after05]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_05after.png
[after06]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_06after.png
[after07]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_07after.png
[after08]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_08after.png
[after09]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_09after.png
[after10]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_10after.png
[after11]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_11after.png

### [`tpope/vim-surround`](https://github.com/tpope/vim-surround)

Quoting/parenthesizing made simple; e.g. ysiw) to wrap word in parens.

### [`tpope/vim-repeat`](https://github.com/tpope/vim-repeat)

Enable repeating supported plug-in maps with [`.`](https://github.com/.)

### [`maxbrunsfeld/vim-emacs-bindings`](https://github.com/maxbrunsfeld/vim-emacs-bindings)

Add emacs/bash/cocoa key bindings to vim, in insert and command-line modes.

### [`matze/vim-move`](https://github.com/matze/vim-move)

Plugin to move lines and selections up and down. `<a-k>`/`<a-j>`.

![vim-move](https://camo.githubusercontent.com/c06acab07e6bf0bb27086c9694fe2f456101d21c/687474703a2f2f692e696d6775722e636f6d2f524d76384b734a2e676966)

### [`junegunn/vim-easy-align`](https://github.com/junegunn/vim-easy-align)

A Vim alignment plug-in. See readme for examples. `ga` gets you in "align mode".

![vim-easy-align](https://raw.githubusercontent.com/junegunn/i/master/easy-align/equals.gif)

### [`tpope/vim-speeddating`](https://github.com/tpope/vim-speeddating)

Use CTRL-A/CTRL-X to increment dates, times, and more.

### [`tommcdo/vim-exchange`](https://github.com/tommcdo/vim-exchange)

Easy text exchange operator for Vim. `cx<motion>` in normal mode or `X` in
visual mode. Running again after making a selection (which will be visually
highlighted) will swap the two regions.
<!--}-->

## General -- Helpful generic tools with no dependencies<!--{-->

### [`tpope/vim-projectionist`](https://github.com/tpope/vim-projectionist)

Project configuration via 'projections'. 

### [`tpope/vim-sleuth`](https://github.com/tpope/vim-sleuth)

Automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the
current file.

### [`tpope/vim-abolish`](https://github.com/tpope/vim-abolish)

Easily search for, substitute, and abbreviate multiple variants of a word.
`:Subvert`, `:Abolish` and coercion.

`:Subert`: case-aware search/replace

This will replace `blog` with `post` or `Blog` with `Post`:
```
:Subvert/blog{,s}/post{,s}/g
```

Coercion: change casing of text, from the docs:

> Want to turn `fooBar` into `foo_bar`?  Press `crs` (coerce to snake\_case).
> MixedCase (`crm`), camelCase (`crc`), snake\_case (`crs`), UPPER\_CASE
> (`cru`), dash-case (`cr-`), dot.case (`cr.`), space case (`cr<space>`), and
> Title Case (`crt`) are all just 3 keystrokes away.  These commands support
> [repeat.vim](https://github.com/tpope/vim-repeat).

### [`tpope/vim-unimpaired`](https://github.com/tpope/vim-unimpaired)

Pairs of handy bracket mappings; e.g. [<Space> and ]<Space> add newlines before
and after the cursor line. See docs for more commands or `:help unimpaired`

### [`tpope/vim-eunuch`](https://github.com/tpope/vim-eunuch)

Vim sugar for the UNIX shell commands that need it the most; e.g. `:Find`, `:Wall`

### [`kopischke/vim-stay`](https://github.com/kopischke/vim-stay)

Make Vim persist editing state without fuss.

### [`kopischke/vim-fetch`](https://github.com/kopischke/vim-fetch)

Make Vim handle line and column numbers in file names with a minimum of fuss.

![vim-fetch](https://github.com/kopischke/vim-fetch/raw/master/img/vim-fetch.gif)

### [`mbbill/undotree`](https://github.com/mbbill/undotree)

The ultimate undo history visualizer for VIM. Activate with `:UndotreeToggle`

![undotree](https://camo.githubusercontent.com/56430626a5444ea2f0249d71f9288775277c7f5d/68747470733a2f2f73697465732e676f6f676c652e636f6d2f736974652f6d6262696c6c2f756e646f747265655f6e65772e706e67)

### [`Konfekt/FastFold`](https://github.com/Konfekt/FastFold)

Speed up Vim by updating folds only when called-for.

### [`mhinz/vim-sayonara`](https://github.com/mhinz/vim-sayonara)

Sane buffer/window deletion. Kill a buffer with `<M-q>`.

### [`junegunn/goyo.vim`](https://github.com/junegunn/goyo.vim)

Distraction-free writing in Vim. Activate with `:Goyo`.

![goyo.vim](https://camo.githubusercontent.com/58569256e607d63a1c6c930d64d80b8d93e8e8c1/68747470733a2f2f7261772e6769746875622e636f6d2f6a756e6567756e6e2f692f6d61737465722f676f796f2e706e67)

### [`junegunn/limelight.vim`](https://github.com/junegunn/limelight.vim)

All the world's indeed a stage and we are merely players.

![limelight.vim](https://camo.githubusercontent.com/fa4e9321be0b4a565ae84a66bae36e97545c101b/68747470733a2f2f7261772e6769746875622e636f6d2f6a756e6567756e6e2f692f6d61737465722f6c696d656c696768742e676966)

### [`benmills/vimux`](https://github.com/benmills/vimux)

Interact with tmux. Used by vim-test or usable on its own. See docs for details
or `:help vimux`.

![vimux](https://camo.githubusercontent.com/5eee3e926a72a57ee65e1760350a7040b31c3b0a/68747470733a2f2f7777772e627261696e747265657061796d656e74732e636f6d2f626c6f672f636f6e74656e742f696d616765732f626c6f672f76696d7578332e706e67)

### [`tpope/vim-dispatch`](https://github.com/tpope/vim-dispatch)

Asynchronous build and test dispatcher. Used by vim-test or usable on its own.
See docs for details or `:help dispatch`.

### [`kassio/neoterm`](https://github.com/kassio/neoterm)

Wrapper of some vim/neovim's :terminal functions.

![neoterm](https://cloud.githubusercontent.com/assets/120483/8921869/fe459572-34b1-11e5-93c9-c3b6f3b44719.gif)

### [`romainl/vim-qf`](https://github.com/romainl/vim-qf)

Tame the quickfix window. `:Reject` to filter out lines, `:Keep` to filter in
and `:Restore` to revert to the original contents.

![vim-qf](https://camo.githubusercontent.com/f141b57c21397b8245afd4cf4448c749f2e971a7/68747470733a2f2f726f6d61696e6c2e6769746875622e696f2f76696d2d71662f66696c7465722e676966)
<!--}-->
