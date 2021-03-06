" vim-plug plugin manager boilerplate
set nocompatible " be iMproved, required filetype off

"---------------------
" BEGIN PLUGIN SECTION

" Install vim-plug if it doesn't exist on the system already
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

"" Plugs Groups
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary' " comment stuff with gc, e.g. gcap
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' " find project root, installed to fix usage issues with fzf.vim
if has('mac')
  Plug '/usr/local/opt/fzf'
elseif has('unix')
  Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
endif
Plug 'mhinz/vim-startify' " useful starting screen
" Plug 'jremmen/vim-ripgrep'
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'unblevable/quick-scope'
" Colorschemes
Plug 'sickill/vim-monokai'
" Plug 'arcticicestudio/nord-vim'
" Plug 'endel/vim-github-colorscheme'
" Plug 'morhetz/gruvbox'
" Plug 'w0ng/vim-hybrid'
" Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'mswift42/vim-themes'
" Plug 'liuchengxu/space-vim-dark'

" Git
Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'

" Ruby
" Plug 'ngmy/vim-rubocop'
" Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'

" Clojure
" TODO: Comment with streamlined guide to configure/use
" Better syntax/filetype support
Plug 'guns/vim-clojure-static',                    { 'for': 'clojure' }
" repl / eval integration
Plug 'tpope/vim-fireplace',                        { 'for': 'clojure' }
" s-expression text-objects
Plug 'guns/vim-sexp',                              { 'for': 'clojure' }
" better + more mappings for vim-sexp
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
" >e, <e: move element
" >f, <f: move form
" <(, >), >(, <): slurp/barf
" leiningen integration
Plug 'tpope/vim-salve', { 'for': 'clojure' }
" paren pairing differentiation
Plug 'kien/rainbow_parentheses.vim', { 'for': 'clojure' }

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Zig
Plug 'ziglang/zig.vim', { 'for': 'zig' }

" Fish syntax highlighting
Plug 'dag/vim-fish', { 'for': 'fish' }

call plug#end()

" runtime macros/matchit.vim " Is this required for something?

colorscheme monokai " loads in 9ms
" colorscheme zenburn

" SETTINGS AND AUTOCOMMANDS

set scrolloff=18 " try to keep cursor centered-ish when scrolling
set ruler " Show line:character in modeline
set number " Show line numbers
set shell=fish
set colorcolumn=81 " highlight 81st column as *suggestion* to keep lines shorter
set clipboard=unnamedplus
set list listchars=tab:▸\ ,eol:¬
set confirm " ask for force instead of making you retype with !
set mouse=a " Enable mouse usage
set inccommand=nosplit " :*s/highlight/livereplace
set completeopt=menuone,noselect,noinsert
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set splitright "open vsplit on right
set splitbelow "open split on bottom
 
" v- gets rid of | in split gutters
set fillchars+=vert:\ 
set t_Co=256
" augroup CursorLineOnlyInActiveWindow
"   autocmd!
"   autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"   autocmd WinLeave * setlocal nocursorline
" augroup END

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

" More ergonomic 'jump-back' shortcut
nnoremap <leader>. ``

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

" source vimrc
nnoremap <leader>v :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>V :e ~/.config/nvim/init.vim<CR>

" Eval whole file (clojure, vim-fireplace)
"nnoremap <leader>E :%Eval<CR>

" Toggle spell-checking
nnoremap <leader>P :set spell!<CR>

" Quick plug update all
nnoremap <leader>U :PlugUpgrade \| PlugClean \| PlugUpdate<CR>

" ---------------------
" BEGIN PLUGIN SETTINGS
" ---------------------

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

lua <<EOF
local lspconfig = require'lspconfig'
local my_on_attach = function(_, bufnr)
  require('completion').on_attach()
  -- require('diagnostic').on_attach()
end
lspconfig.tsserver.setup{
  on_attach = my_on_attach,
}
lspconfig.solargraph.setup{
  on_attach = my_on_attach,
}
EOF

nnoremap <leader>k :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>d :lua vim.lsp.buf.definition()<CR>
