" set nocompatible
" isn't necessary:
" it's set by default and calling it has side effects

"""""""""""""""

"" Uncategorized for now

set path+=**
set wildmenu

"" Backup, swap, undo

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

"" Display

set hlsearch
set nolist listchars=nbsp:⍽,tab:▒░,trail:␣
" set nolist listchars=nbsp:⍽,tab:░░,trail:␣
" set number
set nonumber
set numberwidth=8 " Like less, Mless vi, etc
set scrolljump=-50 " meaning 50%, for emacs-like scroll.
set ruler
set linebreak nobreakindent wrap

""" Colors

" set background=dark
set background=light
set t_Co=16 " limits vim to the 2+16 term colors.
" syntax off
syntax on

"" Keys

" set clipboard=unnamed " ''use OS keyboard'' TODO: test this out.
" set virtualedit=block " Note: virtualmode treats tabs as multiple characters.

" Virtual lines over literal lines
"
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

""" Leader

let mapleader = "	" " tab
let g:mapleader = "	" " tab

nnoremap <leader># :read<space>!qhash<space>8<cr>
nnoremap <leader>/ :nohlsearch<cr>
nnoremap <leader>c :set<space>columns=80<cr>
nnoremap <leader>e :edit<space>**/
nnoremap <leader>n :set<space>number!<cr>
nnoremap <leader>r :read<space>
vnoremap <leader>a :norm<space>A
vnoremap <leader>i :norm<space>0i
vnoremap <leader>n :norm<space>
vnoremap <leader>s :sort<cr>
" TODO: figure out how to unset <leader>c

nnoremap <leader>L :set<space>nolist<cr>
nnoremap <leader>l :set<space>list<cr>

""" Multipurpose tab key
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

"" Plugins

" Builtin ''plugins''
"
runtime ftplugin/man.vim
let g:ft_man_open_mode = 'tab'

" External plugins
"
" Requires minpac: https://github.com/k-takata/minpac
" To bootstrap it, run
" git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
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

"" Text formatting

set autoindent " is necessary for gq to work properly on indented text (it shouldn't be).
set expandtab softtabstop=8 shiftwidth=8 tabstop=8
set nojoinspaces " 1 space after a period.
set modeline
set textwidth=72

set formatoptions= " reset.
" set fo+=t " Auto format with textwidth
" set fo+=c " Auto format comments with textwidth
" set fo+=r " Insert commentstring on insert mode <cr>
" set fo+=o " Insert commentstring on normal mode o and O
set fo+=q " commentstring-aware gq
" set fo+=w " Trailing blanks mean paragraph continues in next line.
" set fo+=a " Auto format with textwidth on inserts and deletes. If 'c' is set, only for comments. See auto-format.
set fo+=n " When formatting text, recognize lists using 'formatlistpat'
" set fo+=2 " Use the indent of line #2 of a paragraph for lines >2, 'autoindent' must be set.
" set fo+=v " (Mostly) Vi-compatible insert mode wrapping.
" set fo+=b " Like 'v', but only before the 'textwidth' wrap margin.
" set fo+=l " Ignore lines longer than 'textwidth' when the insert started.
" set fo+=m " Break at a multi-byte character. For Asian text.
" set fo+=M " Joining lines, don't insert spaces before or after multi-byte characters. Overrules 'B'.
" set fo+=B " Joining lines, don't insert spaces between multi-byte characters. Overruled by 'M'.
" set fo+=1 " Break lines before one-letter words (if possbile).

"""""""""""""""

" Filetype specific overrides
"
if has("autocmd")
	autocmd FileType awk         setl commentstring=#\ %s
	autocmd FileType cfg         setl commentstring=\/\/\ %s       " for goldsrc and source .cfg files.
	autocmd FileType cfg         setl filetype=text                " for goldsrc and source .cfg files.
	autocmd FileType clojure     setl commentstring=;;\ %s
	autocmd FileType go          setl commentstring=\/\/\ %s
	autocmd FileType html        setl commentstring=<!--\ %s\ -->
	autocmd FileType javascript  setl commentstring=\/\/\ %s
	autocmd FileType php         setl commentstring=#\ %s
	autocmd FileType python      setl commentstring=#\ %s
	autocmd FileType readline    setl commentstring=#\ %s
	autocmd FileType sh          setl commentstring=#\ %s
	autocmd FileType tmux        setl commentstring=#\ %s
	autocmd FileType vim         setl commentstring=\"\ %s
	autocmd FileType yaml        setl commentstring=#\ %s
endif
