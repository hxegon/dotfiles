" vim-plug plugin manager boilerplate
set nocompatible              " be iMproved, required
"filetype off                  " required

" If you have a new install, try this command: 
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"---------------------
" BEGIN PLUGIN SECTION
"---------------------

call plug#begin('~/.config/nvim/plugged')

"" Plugs Groups
" Default
" Plug 'scrooloose/syntastic' " Depreciated in favour of the ansynchronous neomake
"Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'townk/vim-autoclose'
Plug 'junegunn/vim-easy-align'
Plug 'xolox/vim-misc'
Plug 'scrooloose/nerdtree'
" Plug 'terryma/vim-expand-region'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'sjl/gundo.vim'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf.vim'
if has('mac')
  Plug '/usr/local/opt/fzf'
elseif has('unix')
  Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
endif
Plug 'tpope/vim-eunuch'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'unblevable/quick-scope'
Plug 'raghur/vim-ghost', { 'do': ':GhostInstall' }
Plug 'mhinz/vim-startify'

" Snippets
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" Colorschemes
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
Plug 'liuchengxu/space-vim-dark'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Ruby
Plug 'ngmy/vim-rubocop'
Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'

" Misc
"Plug 'tomtom/tlib_vim'
" fuzzy file search
" easy gisting, easy life
" Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
" move around a file easier, mapped to <leader><space>
Plug 'easymotion/vim-easymotion'

call plug#end()

runtime macros/matchit.vim
" call deoplete#enable()
" Call neomake automatically when writing and after 750 ms after a normal mode command
"call neomake#configure#automake('nw', 500)
" let g:neomake_warning_sign={'text': 'W'}
" let g:neomake_err_sign={'text': 'E'}
" let g:neomake_info_sign={'text': 'I'}

" COLORSCHEME

colorscheme zenburn
"colorscheme hybrid_material
"set background=dark
"colorscheme alduin
"let g:alduin_Shout_Become_Ethereal = 1

" SETTINGS AND AUTOCOMMANDS

set scrolloff=18
set ruler
set number
set shell=zsh
set colorcolumn=81
set clipboard=unnamedplus
set list listchars=tab:▸\ ,eol:¬
set confirm " ask for force instead of making you recommand with !
set mouse=a " Enable mouse usage
set inccommand=nosplit " :*s/highlight/livereplace
set completeopt=menu,menuone,preview,noselect,noinsert " allegedly fixes ale issue
set splitright "open vsplit on right
set splitbelow "open split on bottom
 
" v- gets rid of | in split gutters
set fillchars+=vert:\ 
set t_Co=256
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Stop automatically inserting comments into newlines after commented lines
au FileType * set fo-=cro

syntax enable
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set nocompatible
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

" MAPPINGS

" alternate leader key: , instead of \
let mapleader = ","
let g:mapleader = ","

" map common ex-command typos to their intended commands
command! Q q
command! W w

" Execute macro in q
map Q @q

" quick save mapping
nnoremap <leader><leader> :w<CR>

nnoremap j gj
nnoremap k gk

" center search matches
nnoremap n nzzzv
nnoremap N Nzzzv

" Escape terminal with normal <esc> key.
tnoremap <Esc> <C-\><C-n>

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

" alternate escape
" nnoremap <leader>. <ESC>
" inoremap <leader>. <ESC>
" vnoremap <leader>. <ESC>

" alternate tilda in normal mode
nnoremap <leader>. ``
vnoremap <leader>. ``

" tabs
"nnoremap <leader>tc :tabnew<CR>
"nnoremap <leader>tx :tabclose<CR>
"nnoremap <leader>ts :tabnew ~/.config/nvim/bundle/vim-snippets/snippets<CR>

" source vimrc
nnoremap <leader>v :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>V :e ~/.config/nvim/init.vim<CR>

" Eval whole file (clojure, vim-fireplace)
"nnoremap <leader>E :%Eval<CR>

" Expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Terminal shortcuts
tnoremap <leader>e <C-\><C-n>

" Toggle spell-checking
nnoremap <leader>P :set spell!<CR>

" Quick plug update all
nnoremap <leader>U :PlugUpgrade \| PlugClean \| PlugUpdate<CR>

" ---------------------
" BEGIN PLUGIN SETTINGS
" ---------------------

" ale
let g:ale_completion_enabled = 1

" Gist plugin settings
let g:gist_post_anonymous = 1
vnoremap <leader>G :Gist -a -b<CR>

" Gundo plugin settings
nnoremap <leader>u :GundoToggle<CR>

" Syntastic
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
nnoremap <leader>se :Errors<CR>
nnoremap <leader>sr :SyntasticReset<CR>

" vim-hardtime settings
" default on
"let g:hardtime_default_on = 1
" set timeout length
"let g:hardtime_timeout = 100

" force vim-vroom mapping
nnoremap <leader>r :VroomRunTestFile<CR>

" NERDtree
nnoremap <leader>n :NERDTreeToggle<CR>

" FZF
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Easy Align Mappings
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Quick comment
nnoremap # :Commentary<CR>
vnoremap # :Commentary<CR>

" Fugitive bindings
" remember, in a status window, '-' adds/removes from staging, and 'p' adds/removes patch wise
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>

" Easymotion
" rebind default leader to not leader leader
map \ <Plug>(easymotion-prefix)
" <space><char> opens bi-directional easymotion character match
nmap <space> <Plug>(easymotion-bd-f)
vmap <space> <Plug>(easymotion-bd-f)

"--------------------
" END PLUGIN SETTINGS
"--------------------
