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

"""""""""""""""""""""""""""""" IDE

"""" TREESITTER """"
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

""" LSPPPPPP """"
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

""" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

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
" Colorschemes
" Plug 'sickill/vim-monokai'
Plug 'arcticicestudio/nord-vim'
Plug 'endel/vim-github-colorscheme'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'Mofiqul/dracula.nvim'
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

colorscheme dracula

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
nnoremap <leader>tg :FloatermNew --title=lazygit($1/$2) --height=0.98 --cwd=<buffer> lazygit<CR>

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

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

lua << EOF
-- WHICH KEY
require("which-key").setup {}
local wk = require("which-key")


-- TREESITTER
local configs = require'nvim-treesitter.configs'

configs.setup {
  -- ensure_installed = "maintained", -- only use maintained parsers


  auto_install = true,
  highlight = { --enable highlighting
    enable = true,
  },
  indent = { -- enable indentation
    enable = true,
  }
}

-- LSP Installer

require("nvim-lsp-installer").setup{}

-- Completion
local cmp = require'cmp'

cmp.setup({

  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment") 
        and not context.in_syntax_group("Comment")
    end
  end, 

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-g>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

    sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    }, {
    { name = 'buffer' },
    })
  })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
  { name = 'buffer' },
  })
})

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- LSP


local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>l.', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, bufopts)
  -- TODO Don't really use workspace functions but should try this out at some point
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)

  -- TODO: Use which key to -define- the above mappings
  -- Register LSP mappings in which key (only when lsp is active in that buffer)
  wk.register({
    l         = {
      name    = "LSP",
      D       = "Declaration",
      d       = "Definition",
      ["."]   = "Hover",
      i       = "Implementation",
      s       = "Signature",
      t       = "Type Definition",
      ["R"]   = "Rename",
      a       = "code action",
      r       = "References",
      f       = "Formatting",
    },
  }, { prefix = "<leader>", buffer = bufnr })
end

-- ADD BORDERS TO SIGNATURE, HOVER POPUP WINDOWS

local border = {
      {"🭽", "FloatBorder"},
      {"▔", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}

local hover_border_handlers = {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border}),
}


local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig['clojure_lsp'].setup{
    on_attach    = on_attach,
    flags        = lsp_flags,
    handlers     = hover_border_handlers,
    capabilities = capabilities,
}

EOF

" nnoremap <leader>k :lua vim.lsp.buf.hover()<CR>
" nnoremap <leader>R :lua vim.lsp.buf.rename()<CR>
" nnoremap <leader>d :lua vim.lsp.buf.definition()<CR>
