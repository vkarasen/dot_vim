set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" let Vundle manage Vundle
" " required! 
Plugin 'gmarik/vundle'

" {{{ Github repositories

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'SirVer/ultisnips'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/DrawIt'
Plugin 'LaTeX-Box-Team/LaTeX-Box'

if v:version >= 704 || (v:version == 703 && has('patch584'))
	Plugin 'Valloric/YouCompleteMe'
endif

" }}}
"
call vundle#end()
filetype plugin indent on    " required

"stuff from the vanilla vimrc..
syntax on
set nocompatible
set encoding=utf-8
set winaltkeys=no
set hidden
set ai

"fix backspace
set backspace=indent,eol,start


" ttyfast: are we using a fast terminal? Let's try it for a while.
set ttyfast

"guistuff
au GUIEnter * simalt ~x
set guioptions=m

"best colorscheme out there <3
if exists('xoria256')
	colo xoria256 
endif

"plugins
com! Be :BufExplorer
"fast access to the vimrc
com! Vimrc e ~/dot_vim/vimrc

"navigation stuff
nnoremap <c-h> gT
nnoremap <c-l> gt

"german keyboards don't like ]
nnoremap <C-i> <C-]>

set wildmenu 
set wildmode=list,full
set nu

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.  filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let mapleader=";"

"small trick to invoke the latex suite when I'm editing something out of
"pentadactyl
au BufEnter *.tmp set ft=tex

"neat trick for hiding highlighting of parentheses
hi MatchParen ctermbg=black guibg=black

com! Plot :! gnuplot "%"

"com! Notes tabe C:\Dokumente und Einstellungen\me\Eigene Dateien\Rainmeter\Skins\Enigma\Sidebar\Notes\notes.txt

au! BufWritePost vimrc source %

set nospell
"set spellcheck if current buffer is a tex file
au FileType tex setlocal spell



set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
set ignorecase
set smartcase
nnoremap <c-u> :nohl<CR>
"inoremap <c-u> <c-o>:nohl<CR>
nnoremap U <c-r>
filetype on
com! -nargs=? Nd NERDTree <args> 
nnoremap nd :NERDTreeFromBookmark  
"com! Texrc :tabe c:\programme\vim\vimfiles\ftplugin\tex.vim
com! Pentadactylrc :tabe ~\pentadactylrc
nnoremap <c-y> :YRShow<cr>
autocmd BufNewFile  *.vhd 0r ~/vkarasen-config/vim/skeleton.vhd

nnoremap tl :Tlist<cr>
nnoremap cd :cd %:h<cr>
set guifont=consolas:h10
com! Vsim silent !modelsim -do sim.do &<cr>
"change the directories for backup and swapfiles to a fixed location
"set dir=c:\tmp\swap
"set bdir=c:\tmp\backup

" trying no backup
set nobackup
set noswapfile

"nmap <Leader>i :Vii<cr>
"invoke the right compiler with the same command depending on the filetype
autocmd FileType vhdl command! MyComp !vcom "%"
autocmd FileType verilog command! MyComp !vlog "%"
nnoremap <c-b> :MyComp<cr>

com! Shell ConqueTermTab cmd
let g:sigPrefix_VIP = ""

"### Searching ###################################################
" highlight search
set hlsearch
" case inferred by default
set infercase
" make searches case-insensitive
set ignorecase
"unless they contain upper-case letters:
set smartcase
" show the `best match so far' as search strings are typed:
set incsearch
" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" ### Line Wrapping ###################################################
" don't make it look like there are line breaks where there aren't:
set nowrap
" Wrap at word
set linebreak

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions=cq
" except when we're writing latex, then also wrap normal text
au FileType tex setlocal formatoptions+=t
set textwidth=120

" Map uppercase write and quit, I'm lazy with shift
cab W w
cab Q q
cab WQ wq
cab WQ! wq!
"move around windows with ctrl key!
nnoremap H <C-W>h
"map J <C-W>j
"map K <C-W>k
"nnoremap J 20j
"nnoremap K 20k
nnoremap L <C-W>l
nnoremap Y y$

" insert new line without going into insert mode
nnoremap <Enter> o<ESC>
nnoremap <S-Enter> :put!=''<CR>
" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq
"allow deleting selection without updating the clipboard (yank buffer)
vnoremap x "_x
vnoremap X "_X
" Easy unload of buffer
map +q :bd<CR>

" Easy quit of vim
map +Q :qall!<CR>

" enhanced commentify
let g:EnhCommentifyPretty = 'Yes'
let g:EnhCommentifyTraditionalMode = 'No'
let g:EnhCommentifyFirstLineMode = 'Yes'
" let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyRespectIndent = 'No'
let g:EnhCommentifyBindInInsert = 'No'
let g:EnhCommentifyUserBindings = 'yes'
"vmap <Leader>x <Plug>VisualFirstLine
"nmap <Leader>x <Plug>FirstLine
"
autocmd FileType python    setlocal tabstop=4 |     setlocal shiftwidth=4 |  setlocal expandtab

if &term =~ '256color'
	" Disable Background Color Erase (BCE) so that color schemes
	"   " work properly when Vim is used inside tmux and GNU screen.
	"     " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif
