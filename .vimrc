set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Surround text-object
Plugin 'tpope/vim-surround'

" Set of sane defaults.
Plugin 'tpope/vim-sensible'

" Code linting on save
Plugin 'scrooloose/syntastic'

" smart tab behaviour
Plugin 'ervandew/supertab'

Plugin 'junegunn/vim-easy-align'

" Colorschemes (KEEP AT END OF PLUGIN LIST)
Plugin 'endel/vim-github-colorscheme'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'morhetz/gruvbox'
Plugin 'w0ng/vim-hybrid'
Plugin 'sickill/vim-monokai'
Plugin 'sjl/badwolf'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'vim-ruby/vim-ruby'
Plugin 'AlessandroYorba/Alduin'
Plugin 'mswift42/vim-themes'
call vundle#end()

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

" Merlin (OCaml)
let g:opamshare = substitute(system('opam config var share'), '\n', '', '''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Merlin mappings
nnoremap <localleader>t :MerlinTypeOf<CR>
nnoremap <localleader>u :MerlinUse 
nnoremap <localleader>l :MerlinLocate<CR>
