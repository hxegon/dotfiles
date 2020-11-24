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
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'xolox/vim-misc'
" Plug 'scrooloose/nerdtree'
" Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary' " comment stuff with gc, e.g. gcap
" Plug 'ervandew/supertab' " Might reenable, messes with tab completion snippet
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' " find project root, installed to fix usage issues with fzf.vim
if has('mac')
  Plug '/usr/local/opt/fzf'
elseif has('unix')
  Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
endif
Plug 'tpope/vim-eunuch' " *shell helpers like :Move, :Mkdir, :Rename 
Plug 'mattn/emmet-vim' " HTML structure completion e.g. sidebar>.side-sub*5<C-y>
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify' " useful starting screen
Plug 'jremmen/vim-ripgrep'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " auto-completion, requires yarn

" Colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'endel/vim-github-colorscheme'
Plug 'Lokaltog/vim-distinguished'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'sickill/vim-monokai'
Plug 'sjl/badwolf'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'vim-ruby/vim-ruby'
Plug 'mswift42/vim-themes'
Plug 'liuchengxu/space-vim-dark'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Ruby
Plug 'ngmy/vim-rubocop'
Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'

" Clojure
Plug 'guns/vim-clojure-static'                    " Better syntax/filetype support
Plug 'tpope/vim-fireplace'                        " repl / eval integration
Plug 'guns/vim-sexp'                              " s-expression text-objects
Plug 'tpope/vim-sexp-mappings-for-regular-people' " better + more mappings for vim-sexp
Plug 'tpope/vim-salve'                            " leiningen integration
Plug 'kien/rainbow_parentheses.vim'               " paren pairing differentiation

" Go
Plug 'fatih/vim-go'

" Zig
Plug 'ziglang/zig.vim'

" Fish syntax highlighting
Plug 'dag/vim-fish'

" Misc
" Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
" move around a file easier, mapped to <leader><space>
Plug 'easymotion/vim-easymotion'

call plug#end()

runtime macros/matchit.vim " Is this required for something?

colorscheme nord

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

" Enables proper terminal colors in iTerm2 (with "report terminal" set to xterm-256color)
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax enable
filetype plugin indent on
set nocompatible
set wildmenu
set showmode
set laststatus=2
set noswapfile
set hidden " might be required for vim-go
set cmdheight=2 " Better message display
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

" Completion settings
" suggested by vim-go
set updatetime=300 " Smaller then default time for CursorHold triggers
set shortmess+=c " Don't clutter with completion menu messages
set signcolumn=yes " Show signcolumns

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

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

" alternate tilda in normal mode. My tmux prefix is `, so this is easier:w
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

" Toggle spell-checking
nnoremap <leader>P :set spell!<CR>

" Quick plug update all
nnoremap <leader>U :PlugUpgrade \| PlugClean \| PlugUpdate<CR>

" ---------------------
" BEGIN PLUGIN SETTINGS
" ---------------------

" Gist plugin settings
" let g:gist_post_anonymous = 1
" vnoremap <leader>G :Gist -a -b<CR>

" Use built in file explorer instead of Nerdtree
nnoremap <leader>n :Sex<CR>

" FZF
let g:fzf_layout = { 'down': '~40%' } " default layout of 'window' is broken for me, and I prefer this anyway
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>

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

" vim-ripgrep
nnoremap <leader>R :Rg<CR>
"nnoremap <leader>r :Rg <C-r>"<CR> " disabled in favor of Coc binding for symbol renaming
let g:rg_derive_root = 1" Show commands

" Coc
" List CoC commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)

" Format selections
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
