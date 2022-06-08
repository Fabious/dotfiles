syntax on
set autoindent
set background=dark
set backspace=indent,eol,start
set cindent
set clipboard=unnamed
set cmdheight=2
set cursorline
set encoding=utf-8
set expandtab
set foldlevel=99
set foldmethod=syntax
set hidden
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
set mouse=a
set nobackup
set nocompatible
set noerrorbells visualbell t_vb=
set nohlsearch
set noshowmatch
set noswapfile
set nowrap
set nowritebackup
set number
set ruler
set scrolloff=8
set shiftwidth=2
set shortmess+=c
set smartcase
set smartindent
set tabstop=2
set termencoding=utf-8
set termguicolors
set ttyfast
set updatetime=100
set wildmenu

" Automatic installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'

call plug#end()

autocmd vimenter * ++nested colorscheme gruvbox

"""" enable 24bit true color
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

if executable('rg')
  let g:rg_derive_root='true'
endif

" mappings
let mapleader = " "
inoremap jk <esc>
nnoremap ; :
inoremap <C-c> <esc>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Open Vim configuration file
nnoremap <silent><leader>1 :e ~/.vimrc<CR>
nnoremap <silent><leader>2 :source ~/.vimrc<CR>
nnoremap <silent><leader>3 :PlugInstall<CR>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 50)
augroup END
