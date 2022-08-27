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
Plug 'easymotion/vim-easymotion'
" prefix is <leader><leader>

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary' " comment stuff with gc, e.g. gcap
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' " find project root, installed to fix usage issues with fzf.vim
Plug 'mhinz/vim-startify' " useful starting screen
Plug 'jremmen/vim-ripgrep'
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Colorschemes
" Plug 'sickill/vim-monokai'
Plug 'arcticicestudio/nord-vim'
Plug 'endel/vim-github-colorscheme'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
" Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'mswift42/vim-themes'
Plug 'liuchengxu/space-vim-dark'
Plug 'folke/which-key.nvim'
" Git
Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'
" Plug 'jreybert/vimagit'
Plug 'voldikss/vim-floaterm'

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

call plug#end()

" runtime macros/matchit.vim " Is this required for something?

colorscheme nord

" SETTINGS AND AUTOCOMMANDS

set scrolloff=8 " try to keep cursor centered-ish when scrolling
set ruler " Show line:character in modeline
" set number " Show line numbers
set shell=zsh
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
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Stop automatically inserting comments into newlines after commented lines
au FileType * set fo-=cro

" Enables proper terminal colors in iTerm2 (with "report terminal" set to xterm-256color)
set termguicolors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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
let mapleader = " "
let g:mapleader = " "

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
" tnoremap <Esc> <C-\><C-n>

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

" ---------------------
" BEGIN PLUGIN SETTINGS
" ---------------------

" FLOATERM
" TODO: tp only opens at whole nvim pwd root, not current buffer project root
" TODO: set defaults for floaterm height/width

let g:floaterm_width = 0.8
let g:floaterm_height = 0.9

" CONSOLE INIT
autocmd VimEnter * :FloatermNew --name=console --silent --opener=edit --autoclose=2 --title=console($1/$2) --cwd=/Users/cooperlebrun

" LAUNCH NEW CONSOLE
nnoremap <leader>tc :FloatermNew --name=console --opener=edit --autoclose=2 --title=console($1/$2) --cwd=/Users/cooperlebrun<CR>

" PROJECT TERMINAL (TODO only opens at pwd root, not buffer root)
nnoremap <leader>tp :FloatermNew --name=project --opener=edit --autoclose=2 --title=project($1/$2) --cwd=<root><CR>

" LAZYGIT
nnoremap <leader>tg :FloatermNew --title=lazygit($1/$2) --height=0.98 lazygit<CR>

" LF FILE MANAGER
nnoremap <leader>tf :FloatermNew --name=lf --title=lf($1/$2) --cwd=<buffer> lf<CR>

" Open console
nnoremap <silent> <leader>tt :FloatermToggle<CR>
" Toggle whatever fterm you're in
tnoremap <silent> <C-h> <C-\><C-n>:FloatermToggle<CR>
" Next fterm
tnoremap <silent> <C-f> <C-\><C-n>:FloatermNext<CR>
" Previous fterm
tnoremap <silent> <C-b> <C-\><C-n>:FloatermPrev<CR>
" KILL fterm
tnoremap <silent> <C-k> <C-\><C-n>:FloatermKill<CR>

" GITGUTTER
nnoremap <leader>hk <Plug>(GitGutterPrevHunk)
nnoremap <leader>hj <Plug>(GitGutterNextHunk)
nnoremap <leader>hs <Plug>(GitGutterStageHunk)

" Use built in file explorer instead of Nerdtree
nnoremap <leader>n :Sex<CR>

" FZF MAPPINGS
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } } " default layout of 'window' is broken for me, and I prefer this anyway
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"

" Search
nnoremap <leader>sp :GFiles<CR>
nnoremap <leader>sf :Files ~/<CR>
nnoremap <leader>sb :Buffers<CR>
nnoremap <leader>sc :Commands<CR>
nnoremap <leader>sr :History<CR>
nnoremap <leader>sl :BLines<CR>

" nnoremap <leader>/ :Rg " Non-helpful, probably needs some options

" Buffer
nnoremap <leader>bd :bd<CR> " delete buffer
nnoremap <leader>bn :bn<CR> " next buffer
nnoremap <leader>bp :bp<CR> " previous buffer
nnoremap <leader>bp :bp<CR> " previous buffer

" Utility
nnoremap <leader>ut :! safari-tab-to-clipboard<CR>
" Quick plug update all
nnoremap <leader>uU :PlugUpgrade \| PlugClean \| PlugUpdate<CR>

" Snippets
" INSTALL ULTISNIPS https://github.com/SirVer/ultisnips
" nnoremap <leader>S :Snippets<CR>

" EasyMotion
" TODO: Integrate with vim-repeat
" https://github.com/tpope/vim-repeat

let g:EasyMotion_smartcase = 1
map , <Plug>(easymotion-prefix)
nmap ,<space> <Plug>(easymotion-overwin-f2)

" Easy Align Mappings
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" which key
lua << EOF
  require("which-key").setup {}
EOF

" Example which-key register (put in lua block)
" https://github.com/folke/which-key.nvim
" wk.register({
"   f = {
"     name = "file", -- optional group name
"     f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
"     r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false, buffer = 123 }, -- additional options for creating the keymap
"     n = { "New File" }, -- just a label. don't create any mapping
"     e = "Edit File", -- same as above
"     ["1"] = "which_key_ignore",  -- special label to hide it in the popup
"     b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
"   },
" }, { prefix = "<leader>" })

lua <<EOF
local lspconfig = require'lspconfig'
local my_on_attach = function(_, bufnr)
  require('completion').on_attach()
  -- require('diagnostic').on_attach()
end
-- Example lsp even tho no TS anymore
-- lspconfig.tsserver.setup{
  -- on_attach = my_on_attach,
-- }
EOF

" nnoremap <leader>k :lua vim.lsp.buf.hover()<CR>
" nnoremap <leader>R :lua vim.lsp.buf.rename()<CR>
" nnoremap <leader>d :lua vim.lsp.buf.definition()<CR>
