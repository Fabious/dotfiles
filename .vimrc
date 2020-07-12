" Fabious Vim Config

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
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

