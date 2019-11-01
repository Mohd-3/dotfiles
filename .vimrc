set term=screen-256color
syntax on
filetype plugin indent on
set background=dark
colorscheme py-darcula

if $TERM == "xterm-256color"
    set t_Co=256
endif

execute pathogen#infect()
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd vimenter * NERDTree

set noshowmode
set laststatus=2

map <C-n> :NERDTreeToggle<CR>

set number relativenumber
set showcmd
set wildmenu
set showmatch

nnoremap j gj
nnoremap k gk

nnoremap B ^
nnoremap E $

let mapleader=","

inoremap jj <Esc>

nnoremap <leader>u :GundoToggle<CR>

set backspace=indent,eol,start
"set visualbell
set noswapfile
set nobackup
set nowb

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set incsearch
set hlsearch
set ignorecase
set smartcase
set clipboard=unnamedplus
