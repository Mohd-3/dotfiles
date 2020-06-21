"set term=screen-256color
set hidden
set nocompatible
set nomodeline
set wildignore+=*/__pycache__/,*/venv/*,*/backendenv/*,*/env/*,*.pyc

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'cohlin/vim-colorschemes'
Plug 'kien/ctrlp.vim'
Plug 'mohd-3/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'tpope/vim-eunuch'
Plug 'yegappan/taglist'
Plug 'jmcantrell/vim-virtualenv'
Plug 'mbbill/undotree'
Plug 'nvie/vim-flake8'
"Plug 'metakirby5/codi.vim'
call plug#end()

if $TERM == "xterm-256color"
    set t_Co=256
endif
set background=dark
colorscheme py-darcula

" if has('termguicolors')
"   set termguicolors
" endif
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
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>a :ZoomToggle<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nnoremap <silent> <leader>k :call flake8#Flake8ShowError()<cr>

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
let g:undotree_SetFocusWhenToggle = 1
let g:flake8_show_in_file = 1

set backspace=indent,eol,start
"set visualbell
set noswapfile
set nobackup
set nowritebackup
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

autocmd BufWritePost *.py call flake8#Flake8()
"autocmd BufReadPost *.py call flake8#Flake8()

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
