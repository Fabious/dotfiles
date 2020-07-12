" Fabious VIM Setup
" various settings
set autoindent                 " Minimal automatic indenting for any filetype
set backspace=indent,eol,start " Proper backspace behavior
set hidden                     " Possibility to have more than one unsaved buffers
set incsearch                  " Incremental search, hit `<CR>` to stop.
set encoding=UTF-8             " necessary for file icons
set relativenumber
set cursorline
set cursorcolumn
set wildmenu                   " Great command-line completion, use `<Tab>` to move
                               " around and `<CR>` to validate
set visualbell                 " Enable vim's internal visual bell
set t_vb=                      " Set the effect of the vim visual bell to do nothing
set tabstop=2 shiftwidth=2 expandtab " Set tabs to space and 2 columns
set list                       " Show all hidden chars
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

call plug#begin('$VIM/plugged')
Plug 'tpope/vim-fugitive'     " Git integration
Plug 'scrooloose/syntastic'   " Syntax checking plugin
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'     " Surround command
Plug 'joshdick/onedark.vim'   " color theme
Plug 'sheerun/vim-polyglot'   " syntax color for different langages
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons' " file icons, must be loaded after affected plugins
call plug#end()

syntax enable
colorscheme onedark

" mappings
let mapleader = ","
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-b> :ls<CR>:b<Space>
nnoremap <C-p> :Files<CR>
nnoremap <C-n> :NERDTree<CR>

if has("gui_running")
  set guifont=Inconsolata:h16:W500:cANSI:qDRAFT
endif

" Use the internal diff if available
" Otherwise use the special 'diffexpr' for Windows
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
