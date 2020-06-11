set term=screen-256color
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set wildignore+=*/__pycache__/,*/venv/*,*/backendenv/*,*/env/*,*.pyc
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'cohlin/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'mohd-3/lightline.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'mileszs/ack.vim'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'tpope/vim-eunuch'
call vundle#end() 
syntax on
filetype plugin indent on
set background=dark
colorscheme py-darcula

if $TERM == "xterm-256color"
    set t_Co=256
endif

"execute pathogen#infect()
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd vimenter * NERDTree
set runtimepath^=~/.vim/bundle/ctrlp.vim

set updatetime=100
set noshowmode
set laststatus=2

set number relativenumber
set showcmd
set wildmenu
set showmatch

nnoremap j gj
nnoremap k gk

nnoremap B ^
nnoremap E $

let mapleader=" "

inoremap jj <Esc>

"nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

vnoremap <Right>  xpgvlolo
vnoremap <left>   xhPgvhoho
vnoremap <Down>   xjPgvjojo
vnoremap <Up>     xkPgvkoko

let @m = 'iclass (models.Model):bbbbbi'
let @s = 'iclass (serializers.Serializer):bbbbbi'
let @v = 'iclass (APIView):bbbi'
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
