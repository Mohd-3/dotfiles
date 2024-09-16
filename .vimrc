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

if has('termguicolors')
    set termguicolors
endif

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

let g:python_highlight_func_calls = 0

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'nordtheme/vim'
Plug 'sheerun/vim-polyglot'
Plug 'mohd-3/lightline.vim'
" Plug 'mohd-3/python-syntax.vim'
Plug 'tomtom/tcomment_vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-eunuch'
Plug 'majutsushi/tagbar'
Plug 'jmcantrell/vim-virtualenv'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'mhinz/vim-startify'
Plug 'joshdick/onedark.vim'
Plug 'jacoborus/tender.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'vim-scripts/VimCompletesMe'
call plug#end()

set background=dark
colorscheme onedark
" colorscheme nord

set completeopt=menu,menuone,preview,noselect,noinsert
autocmd CompleteDone * silent! pclose
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd vimenter * NERDTree

let mapleader=" "
let g:lsc_auto_map = {
    \ 'GoToDefinition': '<leader>d',
    \ 'FindReferences': '<leader>r',
    \ 'FindCodeActions': '<leader>ga',
    \ 'Rename': '<leader>R',
    \ 'ShowHover': v:true,
    \ 'SignatureHelp': '<leader>sh',
    \ 'Completion': 'completefunc',
    \ 'GoToDefinitionSplit': '<leader>sd',
    \}
    " \ 'FindImplementations': '<leader>I',
    " \ 'DocumentSymbol': 'go',
    " \ 'WorkspaceSymbol': 'gS',
    " \ 'NextReference': '<C-n>',
    " \ 'PreviousReference': '<C-p>',

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
" nnoremap <silent> <leader>d :ALEGoToDefinition<CR>
" nnoremap <silent> <leader>r :ALEFindReferences<CR>
nnoremap <silent> <leader>en :ALENext<CR>
nnoremap <silent> <leader>ef :ALEFix<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>gs :G<CR>
nnoremap <silent> <leader>gd :Git diff<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>z :term<CR><C-w>N:resize 10<CR>i
nnoremap <silent> <leader>fz :resize 10<CR>
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>
nnoremap <leader>c :set cuc!<CR>

inoremap jj <Esc>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

vnoremap <Right>  xpgvlolo
vnoremap <left>   xhPgvhoho
vnoremap <Down>   xjPgvjojo
vnoremap <Up>     xkPgvkoko

let g:lsc_server_commands = {
\ 'python': 'pylsp',
\ 'vim' : {
\   'name': 'vim-language-server',
\   'command': 'vim-language-server --stdio',
\      'message_hooks': {
\          'initialize': {
\              'initializationOptions': { 'vimruntime': $VIMRUNTIME, 'runtimepath': &rtp },
\         },
\      },
\   },
\}


let g:ale_linters = { 
\   'python': ['pylsp'],
\   'dart': ['analysis_server'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort', 'remove_trailing_lines', 'trim_whitespace', 'autoimport', 'autoflake'],
\   'html': ['html-beautify'],
\   'dart': ['dart-format', 'remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_python_black_options  = '-S -l 79'
let g:ale_set_highlights = 0
let g:fzf_buffers_jump = 1
let g:undotree_SetFocusWhenToggle = 1
let g:lsc_enable_autocomplete = v:true
let g:lsc_enable_diagnostics   = v:false
let g:lsc_reference_highlights = v:false
let g:lsc_trace_level          = 'off'

let @m = 'iclass (models.Model):bbbbbi'
let @s = 'iclass (serializers.Serializer):bbbbbi'
let @v = 'iclass (APIView):bbbi'

set colorcolumn=80
hi clear SignColumn
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

function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

:autocmd InsertEnter,InsertLeave * set cul!

inoremap <expr> <Tab> getline('.')[col('.')-2] !~ '^\s\?$' \|\| pumvisible()
      \ ? '<C-N>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() \|\| getline('.')[col('.')-2] !~ '^\s\?$'
      \ ? '<C-P>' : '<Tab>'
autocmd CmdwinEnter * inoremap <expr> <buffer> <Tab>
      \ getline('.')[col('.')-2] !~ '^\s\?$' \|\| pumvisible()
      \ ? '<C-X><C-V>' : '<Tab>'
