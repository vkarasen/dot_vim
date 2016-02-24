
" {{{ Prelude

set nocompatible              " be iMproved, required
filetype off                  " required

" Using Vundle as Plugin Manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" " required!
Plugin 'VundleVim/Vundle.vim'

" {{{ Github repositories

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-sleuth'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'vim-scripts/DrawIt'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'kien/ctrlp.vim'
Plugin 'nachumk/systemverilog.vim'
Plugin 'yegappan/mru'
Plugin 'Shougo/unite.vim'
Plugin 'vim-scripts/Super-Shell-Indent'
Plugin 'bling/vim-airline'
if executable('python')
    Plugin 'sjl/gundo.vim'
endif

" }}}

call vundle#end()
" }}}

" {{{ General Settings

filetype plugin indent on
filetype on

" ttyfast: are we using a fast terminal? Let's try it for a while.
set ttyfast

" vim built-in completion
set wildmenu
set wildmode=list,full

syntax on

if has("win16") || has("win32") || has("win64")
    let g:opsystem = "windows"
else
    let g:opsystem = substitute(system('uname'), "\n", "", "")
endif

set listchars=tab:>\ ,trail:\ ,extends:>,precedes:<,nbsp:+

if (g:opsystem != "windows") && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
    " NOTE: These two lines are NOT the same characgters!
    " let &listchars = 'tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7'
     set listchars=tab:▸\ ,extends:⇉,precedes:⇇,nbsp:·,trail:␣
 endif

set list

if v:version >= 703
    set relativenumber
endif
set number

set nocompatible
set encoding=utf-8
set winaltkeys=no
set hidden
set autoindent

set nospell


set cursorline
set autoread

set lazyredraw

set showmatch

"guistuff
au GUIEnter * simalt ~x
set guioptions=m

"best colorscheme out there <3
silent! colo xoria256


"fix backspace
set backspace=indent,eol,start

let mapleader=";"

" trying no backup
set nobackup
set noswapfile

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

set formatoptions=q
if v:version > 703
    set formatoptions+=j
endif

set textwidth=100


if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    "   " work properly when Vim is used inside tmux and GNU screen.
    "     " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" }}}

" {{{ Custom Commands

com! Be Unite buffer

com! Deltrail %s/\s\+$

" }}}

" {{{ Aucmds

" {{{ Filetype specific options

" locally set tab settings everywhere
au! BufEnter * setlocal tabstop=4 | setlocal softtabstop=4 | setlocal shiftwidth=4 | setlocal expandtab

au! FileType tex setlocal formatoptions+=t | setlocal spell

au! FileType vim setlocal foldmethod=marker

au! FileType vhdl setlocal commentstring=--%s

" }}}

"small trick to invoke the latex suite when I'm editing something out of
"pentadactyl
au! BufEnter *.tmp set filetype=tex

au! BufNewFile *.vhd 0r ~/vkarasen-config/vim/skeleton.vhd

au! BufEnter wscript* set filetype=python

au! BufEnter *vimrc set filetype=vim

" sources vim filetypes instantly after writing
" au! BufWritePost filetype=vim source % | <silent> AirlineRefresh
au! BufWritePost * if &ft ==# 'vim' | source % | :silent AirlineRefresh | endif

" this hides matching parentheses in tex files
au! filetype tex hi MatchParen ctermbg=black guibg=black

" }}}

" {{{ Mappings

nnoremap <silent> U :redo<CR>

" changes directory to the one of the current buffer
nnoremap cd :cd %:h<cr>

"moving between tabs
nnoremap <c-h> gT
nnoremap <c-l> gt

nnoremap L <c-w>l
nnoremap H <c-w>h

"j,k now follow wrapped lines
nnoremap j gj
nnoremap k gk

" bigger jumps
nnoremap J 20gj
nnoremap K 20gk

"remap the join hotkey to M
vnoremap M J

nnoremap <silent> <c-u> :nohl<CR>

"german keyboards don't like ]
nnoremap <C-i> <C-]>

" to make Y behave like D
nnoremap Y y$

" insert new line without going into insert mode
nnoremap <Enter> o<ESC>

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq
"allow deleting selection without updating the clipboard (yank buffer)
vnoremap x "_x
vnoremap X "_X

" search for visually highlighted text
vmap // y/<C-R>"<CR>

" }}}

"{{{ Plugin specific stuff

" Gundo
nnoremap <silent> <leader>gt :GundoToggle<CR>
" this moves the preview window below active window instead of tree
let g:gundo_preview_bottom = 1

" {{{ Statusline

" enable statusline
set laststatus=2
set noshowmode

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#whitespace#enabled = 0

" }}}

" }}}
