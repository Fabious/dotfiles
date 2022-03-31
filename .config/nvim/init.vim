syntax enable
set autoindent
set background=dark
set backspace=indent,eol,start
set cindent
set clipboard=unnamed
set encoding=utf-8
set expandtab
set foldlevel=99
set foldmethod=syntax
set hidden
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set mouse=a
set nobackup
set nocompatible
set noerrorbells visualbell t_vb=
set nohlsearch
set noswapfile
set nowritebackup
set number
set numberwidth=4
set ruler
set shiftwidth=2
set showmode
set smartcase
set smartindent
set softtabstop=2
set tabstop=2
set termencoding=utf-8
set ttyfast
set updatetime=300
set wildmenu

colorscheme nightfox

" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited
Plug 'tpope/vim-fugitive'         " :Gblame
Plug 'tpope/vim-rhubarb'          " :GBrowse
Plug 'tpope/vim-surround'         " Surroundings
Plug 'tpope/vim-commentary'       " Comment stuff
Plug 'tpope/vim-endwise'          " Autocomplete end after a do

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'styled-components/vim-styled-components'

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'      " Statusline

Plug 'mileszs/ack.vim'            " Use ack in Vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'           " Set up fzf and fzf.vim
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" All of your Plugins must be added before the following line
call plug#end()

" +++ Mappings +++
" Leader key is SPACE, I find it the best
let mapleader = " "

imap jk <Esc>
" Treat long lines as break lines
map j gj
map k gk
" Enable folding with the z key
nmap z za

" Open Buffer
nnoremap <silent><leader>l :Buffers<CR>
" Vertically split screen
nnoremap <silent><leader>\ :vs<CR>
" Split screen
nnoremap <silent><leader>/ :split<CR>
" Faster saving and exiting
nnoremap <silent><leader>w :w!<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :x<CR>
" Open Vim configuration file for editing
nnoremap <silent><leader>1 :e ~/.config/nvim/init.vim<CR>
" Source Vim configuration file
nnoremap <silent><leader>2 :source ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>3 :PlugInstall<CR>
" Toggle relative line numbers
nnoremap <leader>rn :set relativenumber!<cr>
" Extra <CR> is for disabling /"Press ENTER or type command to continue/"
nnoremap <silent><leader>e :Exp<CR><CR>
" Easier movement between split windows CTRL + {h, j, k, l}
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" +++ FZF plugin +++
" If fzf installed using git
set rtp+=~/.fzf
" Map fzf search to CTRL P
nnoremap <C-p> :GFiles<Cr>
" Map fzf + ag search to CTRL G
nnoremap <C-g> :Rg <Cr>

" +++ Ack plugin +++
" Ack tricks
let g:ackprg = 'rg --vimgrep --smart-case --hidden'
" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1
nmap <leader>a :Ack!<Space>
nmap <leader>A :Ack! <cword><CR>

" +++ CoC plugin +++
let g:coc_global_extensions = ['coc-tsserver', 'coc-json']
" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>c  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Format
nmap <leader>f   :CocCommand prettier.formatFile<CR>

" +++ Miscellaneous +++
" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

" Spellcheck for features and markdown
au BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.md.erb setlocal spell
au BufRead,BufNewFile *.feature setlocal spell
" Fix some weird error with Fugitive
let g:fugitive_pty = 0

" Change cursor to solid vertical line
" There are problems with Vim's floating window setting cursor to a solid
" block. So these lines below are resetting it to a solid vertical line.
let &t_SI = "\e[6 q"
let &t_EI = "\e[6 q"

" Optionally reset the cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[6 q"
augroup END

" Highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank()
