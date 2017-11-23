set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

" Surround text-object
Plug 'tpope/vim-surround'

" Set of sane defaults.
Plug 'tpope/vim-sensible'

" Code linting on save
Plug 'scrooloose/syntastic'

" smart tab behaviour
Plug 'ervandew/supertab'

Plug 'junegunn/vim-easy-align'

" Colorschemes (KEEP AT END OF PLUGIN LIST)
Plug 'endel/vim-github-colorscheme'
Plug 'Lokaltog/vim-distinguished'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'sickill/vim-monokai'
Plug 'sjl/badwolf'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'vim-ruby/vim-ruby'
Plug 'AlessandroYorba/Alduin'
Plug 'mswift42/vim-themes'

" Haskell
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'eagletmt/neco-ghc'
call plug#end()

syntax enable
filetype plugin indent on

colorscheme monokai

set scrolloff=4
set ruler
set number
set shell=zsh
set colorcolumn=81
"set clipboard=unnamedplus
set list listchars=tab:▸\ ,eol:¬
set omnifunc=syntaxcomplete#Complete

set wildmenu
set showmode
set laststatus=2
set noswapfile
set hidden
set nobackup
set autoread
set ttyfast
" Search
set ignorecase
set smartcase
set incsearch
" indentation rules
set smartindent " Auto indent
set expandtab " use spaces as tabs
set softtabstop=2
set tabstop=2
set shiftwidth=2
set ttimeoutlen=-1

" alternate leader key: , instead of \
let mapleader = ","
let g:mapleader = ","
let maplocalleader = " "
let g:maplocalleader = " "

" map common ex-command typos to their intended commands
command! Q q
command! W w

" Execute macro in q
map Q @q

nnoremap j gj
nnoremap k gk

" center search matches
nnoremap n nzzzv
nnoremap N Nzzzv

" Y yanks to end of line like other capitals
map Y y$

" Remap H and L to go to the beginning and end of the line  
nnoremap H ^
vnoremap H ^
nnoremap L g_
vnoremap L g_

" melody option for split navigation
nnoremap <leader>w <c-w>

" turn off search highlighting
nnoremap <leader><BS> :nohlsearch<CR>

" alternate tilda in normal mode, because my tmux prefix is also tilda
nnoremap <leader>. ``
vnoremap <leader>. ``

" Open .vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
" source .vimrc
nnoremap <leader>V :source ~/.vimrc<CR>

" PLUGIN CONFIG

" Syntastic
let g:syntastic_ocaml_checkers = ['merlin']

" SuperTab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" Haskell
nnoremap <leader>tw :GhcModTypeInsert<CR>
nnoremap <leader>ts :GhcModSplitFunCase<CR>
nnoremap <leader>tq :GhcModType<CR>
nnoremap <leader>te :GhcModTypeClear<CR>
