scriptencoding utf-8

let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_lists = [
                  \ { 'type': 'dir',       'header': [   'MRU ' . getcwd()] },
                  \ { 'type': 'files',     'header': [   'MRU']             },
                  \ { 'type': 'sessions',  'header': [   'Sessions']        },
                  \ { 'type': 'bookmarks', 'header': [   'Bookmarks']       },
                  \ { 'type': 'commands',  'header': [   'Commands']        },
                  \ ]

let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}, '~/.zshrc' ]

let s:version = split(execute('version'), '\n')[0]

let g:startify_custom_header = [
                  \ '                       █▀▀▄ █▀▀ █▀▀█ ▀█░█▀ ░▀░ █▀▄▀█',
                  \ '                       █░░█ █▀▀ █░░█ ░█▄█░ ▀█▀ █░▀░█',
                  \ '                       ▀░░▀ ▀▀▀ ▀▀▀▀ ░░▀░░ ▀▀▀ ▀░░░▀',
                  \ '              config by Luan Santos <https://github.com/luan>',
                  \ printf('   Neovim Version: %-15s %35s', s:version, '(run :version for more details)'),
                  \ ]

