scriptencoding utf-8

set autoread              " reload changes from disk
set autowriteall          " Writes on make/shell commands
set ignorecase            " Case insensitive search
set smartcase             " ... but case sensitive when uc present
set scrolloff=5           " Minumum lines to keep above and below cursor
set nowrap                " Do not wrap long lines
set shiftwidth=2          " Use indents of 2 spaces
set tabstop=2             " An indentation every four columns
set softtabstop=2         " Let backspace delete indent
set splitright            " Vertical splits to the right
set expandtab             " Tabs are spaces, not tabs
set mouse=a               " Mouse enabled in all modes
set mousehide             " Hide the mouse cursor while typing
set hidden                " Allow buffer switching without saving
set showmode              " Show current mode in command-line
set showmatch             " Show matching brackets/parentthesis
set matchtime=1           " Time to show the match for
set report=0              " Always report changed lines
set linespace=0           " No extra spaces between rows
set pumheight=20          " Avoid the pop up menu occupying the whole screen
set wildmode=list:longest " Use emacs-style tab completion in command mode
set iskeyword+=$,@,-      " Add extra characters that are valid parts of variables
set termguicolors         " Enable true colors in terminal
set lazyredraw            " Wait until actions are done to re-render text

set completeopt=menu,noinsert,noselect
set viewoptions=cursor,folds,slash,unix
set fileformats=unix,dos,mac

set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

set undofile             " Persistent undo
set undolevels=1000      " Maximum number of changes that can be undone
set undoreload=10000     " Maximum number lines to save for undo on a buffer reload

set fillchars=vert:│,stl:\ ,stlnc:\ 

set directory=/tmp//,.
set backupdir=/tmp//,.

set foldenable
set foldmarker={,}
set foldlevel=0
set foldmethod=marker
set foldlevelstart=99

" Mimic behavior from D, C
nnoremap Y y$

nnoremap <expr> <CR> empty(&buftype) ? ':w<CR>' : '<CR>'

vnoremap < <gv
vnoremap > >gv

nnoremap <silent> <esc> :noh<cr>

" Replace in visual mode without copying
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Replace()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

vnoremap <silent> <expr> p <sid>Replace()

augroup config#basic
  autocmd!
  " Reload file on focus
  autocmd FocusGained * :checktime
  " Don't format when adding lines with o/O
  autocmd BufNewFile,BufEnter * set formatoptions-=o
augroup END

