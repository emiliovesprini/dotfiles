" set nocompatible
" isn't necessary:
" it's set by default and calling it has side effects

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" # Backup, swap, undo

" What the defaults should be:
"
set backupdir=$XDG_DATA_HOME/vim/backup
set directory=$XDG_DATA_HOME/vim/swap
set undodir=$XDG_DATA_HOME/vim/undo
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
"
" Now that the defaults aren't insane,
" all of these can be turned on:
"
set backup writebackup
set noswapfile " is now off again because it caused problems unreasonably.
set undofile " for persistent undo.

" # Display

set hlsearch
set number
" set nonumber
set numberwidth=8
set scrolljump=-50 " meaning 50%, for emacs-like scroll.
set ruler
set wrap linebreak breakindent

" ## Colors

set background=dark
" set background=light
set t_Co=16 " limits vim to the 2+16 term colors.
" syntax off
syntax on

" set list listchars=tab:▒░,trail:▕
" highlight SpecialKey ctermfg=8

" set background=light
" highlight SpecialKey ctermfg=7

" # Keys

" set clipboard=unnamed " ''use OS keyboard'' TODO: test this out
set paste
set virtualedit=all

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" ## Fix vim commands

" In what context would you indent anything other than lines?
"
nnoremap < <<
nnoremap > >>

" ## Leader

let mapleader = ","
let g:mapleader = ","

nnoremap <leader># :read<space>!qhash<space>8<cr>
nnoremap <leader>/ :nohlsearch<cr>
nnoremap <leader>c :set<space>columns=80<cr>
nnoremap <leader>n :set<space>number!<cr>
nnoremap <leader>r :read<space>
vnoremap <leader>a :norm<space>A
vnoremap <leader>i :norm<space>0i
vnoremap <leader>n :norm<space>
vnoremap <leader>s :sort<cr>
" TODO: figure out how to unset <leader>c

nnoremap <leader>B vip:write<space>!bash<cr>
nnoremap <leader>b :.write<space>!bash<cr>
vnoremap <leader>b :write<space>!bash<cr>

nnoremap <leader>W vip:write<space>
nnoremap <leader>w :.write<space>
vnoremap <leader>w :write<space>

" ## Multipurpose tab key
"
" From https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" Modified to work with <c-n> instead of <c-p>
"
" Indent when at the beginning of a line,
" otherwise do completion:
"
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col
                return "\<tab>"
        endif
        let char = getline('.')[col - 1]
        if char =~ '\k' " there's an identifier before the cursor
                return "\<c-n>" " complete the identifier
        else
                return "\<tab>"
        endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-p>

" # Plugins

" Builtin ''plugins'':
"
runtime ftplugin/man.vim
let g:ft_man_open_mode = 'tab'

" External:
"
" Requires minpac: https://github.com/k-takata/minpac
" To bootstrap it, run
"         git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
"
packadd minpac " tries to load minpac.
if exists('*minpac#init')
        call minpac#init()

        " Commands
        "
        command! MinpacClean  packadd minpac | source $MYVIMRC | call minpac#clean()
        command! MinpacStatus packadd minpac | source $MYVIMRC | call minpac#status()
        command! MinpacUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})

        " ## Plugins

        " minpac is itself a plugin
        "
        " After its been bootstrapped,
        " it can update itself. I think
        "
        call minpac#add('https://github.com/k-takata/minpac', {'type': 'opt'})

        " editorconfig adjusts settings according to .editorconfig files
        "
        call minpac#add('https://github.com/editorconfig/editorconfig-vim')

        " commentary provides mappings for commenting lines
        "
        call minpac#add('https://github.com/tpope/vim-commentary')

        " fireplace integrates with clojure repl
        "
        call minpac#add('https://github.com/tpope/vim-fireplace')

        " fugitive provides :GBlame and git things I shouldn't get used to
        "
        call minpac#add('https://github.com/tpope/vim-fugitive')

        " go adds lots of go language features
        "
        call minpac#add('https://github.com/fatih/vim-go')
        let g:go_template_autocreate = 0 " don't prepopulate new files
        let g:go_fmt_autosave = 1
        let g:go_fmt_command = "gofmt"
        let g:go_fmt_options = {
        \ 'gofmt': '-s',
        \ 'goimports': ''
        \ }

        " rainbow_parentheses
        "
        call minpac#add('https://github.com/junegunn/rainbow_parentheses.vim')
        let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

        " surround provides mappings to easily
        " delete, change and add
        " ''surroundings'' in pairs
        "
        call minpac#add('https://github.com/tpope/vim-surround')
endif

" # Text formatting

set expandtab softtabstop=8 shiftwidth=8 tabstop=8
set modeline
set nojoinspaces
" set textwidth=80
set textwidth=72

set formatoptions= " to start with a blank slate.
set fo+=n " Recognize numbered lists (uses variable formatlistpat).
set fo+=o " Auto insert comment leader after hitting o or O in normal mode.
set fo+=q " Allow formatting of comments with gq command.
set fo+=r " Auto insert comment leader after hitting enter in insert mode.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Filetype specific overrides:
"
autocmd FileType awk         setlocal commentstring=#\ %s
autocmd FileType cfg         setlocal commentstring=\/\/\ %s  " for goldsrc and source .cfg files.
autocmd FileType cfg         setlocal filetype=text           " for goldsrc and source .cfg files.
autocmd FileType clojure     setlocal commentstring=;;\ %s
autocmd FileType go          setlocal commentstring=\/\/\ %s
autocmd FileType html        setlocal commentstring=<!--\ %s\ -->
autocmd FileType javascript  setlocal commentstring=\/\/\ %s
autocmd FileType php         setlocal commentstring=#\ %s
autocmd FileType python      setlocal commentstring=#\ %s
autocmd FileType readline    setlocal commentstring=#\ %s
autocmd FileType sh          setlocal commentstring=#\ %s
autocmd FileType tmux        setlocal commentstring=#\ %s
autocmd FileType vim         setlocal commentstring=\"\ %s
autocmd FileType yaml        setlocal commentstring=#\ %s
