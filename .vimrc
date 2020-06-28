" set term=screen-256color
set hidden
set nocompatible
set nomodeline
set wildignore+=*/__pycache__/,*/venv/*,*/backendenv/*,*/env/*,*.pyc

set updatetime=100
set laststatus=2

set number relativenumber
set showcmd
set wildmenu
set showmatch
set signcolumn=yes

set winminheight=0
set winminwidth=0
set splitbelow
set splitright

set backspace=indent,eol,start
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

if $TERM == "xterm-256color"
    set t_Co=256
endif

" if has('termguicolors')
"     set termguicolors
" endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'cohlin/vim-colorschemes'
Plug 'mohd-3/lightline.vim'
Plug 'mohd-3/python-syntax.vim'
Plug 'tomtom/tcomment_vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'tpope/vim-eunuch'
Plug 'majutsushi/tagbar'
Plug 'jmcantrell/vim-virtualenv'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'Vimjas/vim-python-pep8-indent'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'metakirby5/codi.vim'
call plug#end()

set background=dark
colorscheme py-darcula

"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd vimenter * NERDTree

let mapleader=" "

nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap Y y$
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>a :ZoomToggle<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nnoremap <silent> <leader>pp :Ag<CR>
nnoremap <silent> <leader>pf :Files<CR>
nnoremap <silent> <leader>pg :GFiles<CR>
nnoremap <silent> <leader>ps :GFiles?<CR>
nnoremap <silent> <leader>pt :Tags<CR>
nnoremap <silent> <leader>pb :Buffers<CR>
nnoremap <silent> <leader>pc :Commits<CR>
nnoremap <silent> <leader>pcc :BCommits<CR>
nnoremap <silent> <leader>ph :History<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>d :ALEGoToDefinition<CR>
nnoremap <silent> <leader>r :ALEFindReferences<CR>
nnoremap <silent> <leader>en :ALENext<CR>
nnoremap <silent> <leader>ef :ALEFix<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>gs :G<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>

inoremap jj <Esc>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

vnoremap <Right>  xpgvlolo
vnoremap <left>   xhPgvhoho
vnoremap <Down>   xjPgvjojo
vnoremap <Up>     xkPgvkoko

let g:ale_linters = { 
\   'python': ['pyls'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort']
\}
let g:ale_python_black_options  = '-S -l 79'
let g:ale_set_highlights = 0
let g:fzf_buffers_jump = 1
let g:undotree_SetFocusWhenToggle = 1
let @m = 'iclass (models.Model):bbbbbi'
let @s = 'iclass (serializers.Serializer):bbbbbi'
let @v = 'iclass (APIView):bbbi'

" match Error /\%81v.\+/
set colorcolumn=80
hi ColorColumn ctermbg=236 guibg=grey19
hi signcolumn ctermbg=235 guibg=grey17

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

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" inoremap <silent><expr> <c-space> coc#refresh()
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <leader>rn <Plug>(coc-rename)
