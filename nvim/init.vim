" This must be first, because it changes other options as side effect
set nocompatible

filetype off                    " force reloading *after* pathogen loaded
set rtp+=~/.local/share/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Plugin here:
"
" original repos on github
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'burnettk/vim-angular'
Plugin 'chriskempson/base16-vim'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'othree/html5.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/unite.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " enable detection, plugins and indenting in one step

" Change the mapleader from \ to ,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" autocmd VimEnter * set vb t_vb=

" Theme settings
syntax enable
set background=dark
colorscheme base16-tomorrow

" Airline
let g:airline_powerline_fonts = 1   " enable fancy symbols (requires patched font)

" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
                                " but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set laststatus=2

set nobackup
set noswapfile
set hidden

" filetype specific config
autocmd FileType php setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType twig setlocal shiftwidth=2 tabstop=2 softtabstop=2

" PHP Settings
let php_sql_query = 1
let php_htmlInStrings = 1
let php_noShortTags = 1

" ctrlp settings
let g:ctrlp_dotfiles = 0

nnoremap <leader>/ :<C-u>nohlsearch<CR>
nnoremap <leader>w <C-w>v<C-w>l

" Unite
let g:unite_split_rule = 'botright'
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>r :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <leader>b :<C-u>Unite -buffer-name=buffers -quick-match buffer<CR>
nnoremap <leader>y :<C-u>Unite history/yank<CR>
nnoremap <C-b> :<C-u>Unite -buffer-name=buffers -start-insert buffer<CR>

" Platinum searcher
nnoremap <leader>f :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

" Buffers shortcuts
nnoremap <leader>l :<C-u>bnext<CR>
nnoremap <leader>h :<C-u>bprevious<CR>
nnoremap <leader>1 :<C-u>buffer 1<CR>
nnoremap <leader>2 :<C-u>buffer 2<CR>
nnoremap <leader>3 :<C-u>buffer 3<CR>
nnoremap <leader>4 :<C-u>buffer 4<CR>
nnoremap <leader>5 :<C-u>buffer 5<CR>
nnoremap <leader>6 :<C-u>buffer 6<CR>

" NERDTree shortcut
nnoremap <leader>n :<C-u>NERDTreeToggle<CR>
