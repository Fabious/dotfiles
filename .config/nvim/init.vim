syntax enable
set autoindent
set background=dark
set backspace=indent,eol,start
set cindent
set clipboard=unnamedplus
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
" set list
" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
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
set softtabstop=2
set tabstop=2
set termencoding=utf-8
set ttyfast
set updatetime=100
set wildmenu

" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'airblade/vim-gitgutter'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components'

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call plug#end()

" THEME
if (has("termguicolors"))
  set termguicolors
endif
colorscheme gruvbox
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ }
      \ }

" === Mappings ===
let mapleader = " "
imap jk <Esc>
nmap z za
" Treat long lines as break lines
map j gj
map k gk
nnoremap q: <nop>
nnoremap Q <nop>
nnoremap <silent><leader>\ :vs<CR>
nnoremap <silent><leader>/ :split<CR>
nnoremap <silent><leader>o :only<CR>
" Faster saving and exiting
nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :x<CR>
nnoremap <silent><leader>e :Exp<CR><CR>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" Fast config
nnoremap <silent><leader>1 :e ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>2 :source ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>3 :PlugInstall<CR>

" Highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank()
" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

" === FZF plugin ===
" If fzf installed using git
" set rtp+=~/.fzf
" Map fzf search to CTRL P
nnoremap <C-p> :GFiles<Cr>
nmap <leader>pf :Files<Cr>
nmap <leader>l :Buffers<CR>
" Map fzf + ag search to CTRL G
nnoremap <C-g> :Rg <Cr>


" === Ack plugin ===
" Ack tricks
let g:ackprg = 'rg --vimgrep --smart-case --hidden'
" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1
nmap <leader>a :Ack!<Space>
nmap <leader>A :Ack! <cword><CR>

" === CoC plugin ===
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-prettier', 'coc-eslint', 'coc-snippets']

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>af  <Plug>(coc-fix-current)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f   :CocCommand prettier.formatFile<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
