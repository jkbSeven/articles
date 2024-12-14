" --- remap ---

let mapleader = " "

nnoremap <leader>ls :Ex<CR>

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

nnoremap J mzJ`z

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz



" --- set ---

set guicursor=

set number
set relativenumber

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set smartindent

set nowrap

set noswapfile
set nobackup
if has("persistent_undo")
    let undodir=expand("~/.vim/undodir")
    set undofile
endif

set nohlsearch
set incsearch

" Enable true color support, sometimes it makes things worse
" if has("termguicolors")
"     set termguicolors
" endif

set scrolloff=8
set isfname+=@-@

set updatetime=50

set colorcolumn=120
