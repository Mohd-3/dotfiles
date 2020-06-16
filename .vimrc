"set term=screen-256color
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
Plugin 'yegappan/taglist'
Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'metakirby5/codi.vim'
call vundle#end() 
syntax on
filetype plugin indent on
if $TERM == "xterm-256color"
    set t_Co=256
endif
set background=dark
colorscheme py-darcula

"set termguicolors
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

set winminheight=0
set winminwidth=0
set splitbelow
set splitright

let mapleader=" "

nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap Y y$
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>a :ZoomToggle<CR>
"nnoremap <leader>u :GundoToggle<CR>

inoremap jj <Esc>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

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

match Error /\%81v.\+/

if has('persistent_undo')
    let path_to_undodir = expand('~/.vim/undo_dir/')
    if !isdirectory(path_to_undodir)
        silent call system('mkdir -p ' . path_to_undodir)
    endif
    let &undodir = path_to_undodir
    set undofile
endif

function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
