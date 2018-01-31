set nocompatible " Tell vim not to pretend to be oldschool VI
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'gmarik/Vundle.vim'

" Plugins ===================================
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'moll/vim-bbye.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'bling/vim-airline.git'
Plugin 'rking/ag.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'edkolev/tmuxline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'
Plugin 'chip/vim-fat-finger.git'
Plugin 'mxw/vim-jsx'
Plugin 'othree/csscomplete.vim'
Plugin 'mattn/emmet-vim'
Plugin 'rstacruz/vim-closer'
Plugin 'leafgarland/typescript-vim'
Plugin 'w0rp/ale'
Plugin 'Shougo/deoplete'
Plugin 'steelsojka/deoplete-flow'
Plugin 'mhartington/nvim-typescript'


call vundle#end()            " required
filetype plugin indent on    " required

" plugin junkyard =============================
"Plugin 'ajh17/VimCompletesMe'
"Plugin 'rstacruz/vim-hyperstyle'
"Plugin 'fatih/vim-go.git'
"Plugin 'kchmck/vim-coffee-script.git'
"Plugin 'rust-lang/rust.vim.git'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'
"Plugin 'ervandew/supertab.git'
"Plugin 'digitaltoad/vim-pug'


" Settings ====================================
set shortmess=a                          " Use shorter messages to avoid the click enter to continue warning
set path+=**                             " Set path search recursive
set autoindent                           " Copy indent from last line when starting new line
set backspace=indent,eol,start
set colorcolumn=120                      " 120 width guideline
set cursorline cursorcolumn              " Highlight current line, and column
set diffopt=filler                       " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite                      " Ignore whitespace changes (focus on code changes only)
set encoding=utf-8 nobomb
set expandtab                            " Expand tabs to spaces
"set foldcolumn=0                         " Column to show folds
"set foldenable                           " Enable folding
"set foldlevel=0                          " Close all folds by default
"set foldmethod=syntax                    " Syntax are used to specify folds
"set foldminlines=0                       " Allow folding single lines
"set foldnestmax=5                        " Cap folding nesting level
set formatoptions=
set formatoptions+=c                     " Format comments
set formatoptions+=r                     " Continue comments by default
set formatoptions+=o                     " Make comment when using o or O from comment line
set formatoptions+=q                     " Format comments with gq
set formatoptions+=n                     " Recognize numbered lists
set formatoptions+=2                     " Use indent from 2nd line of a paragraph
set formatoptions+=1                     " Don't break lines that are already long
set formatoptions+=1                     " Break before 1-letter words
set gdefault                             " By default add g flag to search/replace. Add g to toggle
set hidden                               " When a buffer is brought to foreground, remember undo history and marks
set history=1000                         " Increase history from 20 default to 1000
set hlsearch                             " Highlight searches
set ignorecase                           " Ignore case of searches
set incsearch                            " Highlight dynamically as pattern is typed
set laststatus=2                         " Always show status line
set lazyredraw                           " Don't redraw when we don't have to
set magic                                " Enable extended regexes
set mouse+=a                             " Enable mouse in all modes
set nojoinspaces                         " Only insert single space after a '.', '?', and '!' witha join command
set nostartofline                        " Don't reset the cursor to the start of the line when moving around
set noswapfile                           " Do not use swap files
set nowrap                               " Do not wrap lines
set number relativenumber                " Enable relative line numbers
set ofu=syntaxcomplete#Complete          " Set omni-completion method
set report=0                             " Show all changes
set ruler                                " Enable coordinates in bottom right
set scrolloff=5                          " Start scrolling 5 lines from window border
set smartcase                            " Ignore ignorecase if search contains uppercase
set smarttab                             " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2                        " Tab key results in 2 spaces
set shiftwidth=2                         " Indintation
set splitbelow                           " New window goes below
set splitright                           " New windows goes right
set tabstop=2                            " Hitting <Tab> will produce 2 spaces
set title                                " Show the filename in the window titlebar
set ttyfast                              " Send more characters at a given time
set undofile                             " Persistent Undo
set visualbell                           " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB>                       " Character for CLI expansion (TAB-completion)
set wildmenu                             " Hitting TAB in command mode will show possible completions above command line
set wildmode=list:longest                " Complete only until point of ambiguity
set winminheight=0                       " Allow splits to be reduced to a single line
set wrapscan                             " Searches wrap around end of file

if has('nvim')
  " some neovim specific configs
else
  " some vim specific configs
  set viminfo=%,'9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
  set ttymouse=xterm                       " Set mouse type to xterm
endif


set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll

set wildignore+=.DS_Store,*/bower_components/*,*/node_modules/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*

let mapleader = ","

" auto toggle hybrid-relative line numbers when a buffer is focused
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END



" Config ====================================
" Local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

command! MakeTags !ctags -R --exclude=.git --exclude=log --exclude=node_modules .

" FastEscape
" Speed up transition from modes
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Toggle show tabs and trailing spaces (,c)
set lcs=tab:»·,trail:·,eol:¬,nbsp:_,extends:>,precedes:<
set fcs=fold:-
nnoremap <silent> <leader>c :set nolist!<CR>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" comma period opens silver searcher
noremap <Leader>. :Ag<Space>

" comma j runs JSHint
"noremap <Leader>j :JSHint<CR>
" set runtimepath+=~/.vim/bundle/jshint2.vim/

map <Leader>/ :NERDTreeToggle<CR>
"map <Leader>/ :Vexplore<CR>
"map <leader>/ :call VexToggle(getcwd())<CR>

" nerdtree shows hidden files
let NERDTreeShowHidden=1

" close vim if nerdtree is only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" CTRL-P
let g:ctrlp_map = '<leader>,'
let g:ctrlp_command = 'CtrlP'
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](.git|.svn|vendor|node_modules)'
      \ }

" Change shape of cursor in different modes
" OSX ---
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical line in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
  else
    " tmux on OSX ---
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
endif


" move between buffers in a window
map <leader>m :bnext<CR>
map <leader>n :bprevious<CR>

" close pane
map <leader>x :x<CR>

" close current buffer without closing window
" uses vim-bbye plugin
noremap <leader>w :Bdelete<CR>

" open new empty buffer in current window
map <leader>b :ene<CR>

" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

if &term =~ '^screen'
  set ttymouse=xterm2
endif

" powerline stuff
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

colorscheme onedark
"colorscheme dannzzor
"set background=dark

"let g:one_allow_italics=1
let g:airline_theme='dannzzor'
let g:tmuxline_preset = {
      \'a'    : '#(whoami)',
      \'b'    : '#W',
      \'c'    : '#(date)',
      \'x'    : '#(tmux-mem-cpu-load --interval 2)',
      \'y'    : 'up #(uptime | cut -d " " -f 1,2,3)',
      \'z'    : 'DANNZZOR'}
"let g:tmuxline_preset = {
"      \'a'    : '#(whoami)',
"      \'b'    : '#W',
"      \'c'    : '#H',
"      \'win'  : '#I #W',
"      \'cwin' : '#I #W',
"      \'x'    : '#(tmux-mem-cpu-load --interval 2)',
"      \'y'    : '%a %R',
"      \'z'    : '#(ip)'}


noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Remap Ctrl-x-f to use relative path instead of from PWD 
inoremap ./<C-X><C-F> <C-O>:lcd %:p:h<CR><C-X><C-F>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


syntax enable

" Prettier Config
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'none'

" ALE configuration
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'typescript': ['tslint', 'prettier']
\}

let g:ale_completion_enabled = 1
let g:ale_echo_msg_warning_str = '△'
let g:ale_echo_msg_error_str = '⨯'
let g:ale_echo_msg_format = '[%severity% %linter%] %s' 
let g:ale_linters = {
\ 'javascript': ['flow', 'jshint'],
\ 'typescript': ['flow', 'tslint']
\}

" ALE fix on save
let g:ale_fix_on_save = 1

" deoplete
let g:deoplete#enable_at_startup = 1
