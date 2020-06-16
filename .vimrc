" Fabious Vim Config
" Automatic Install VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kien/ctrlp.vim'
call plug#end()

" enable the theme
let g:gruvbox_contrast_dark = 'hard'
autocmd vimenter * colorscheme gruvbox

" mappings
map <SPACE> <leader>
:imap jk <Esc>
:imap kj <Esc>
nnoremap zz :update<cr>
map <C-n> :NERDTreeToggle<CR>

" various settings
set autoindent                 " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start " Proper backspace behavior.
set hidden                     " Possibility to have more than one unsaved buffers.
set incsearch                  " Incremental search, hit `<CR>` to stop.
set wildmenu                   " Great command-line completion, use `<Tab>` to move
                               " around and `<CR>` to validate.
set number
set relativenumber
set cursorline
set cursorcolumn

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
