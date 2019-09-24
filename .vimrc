" common mistakes
command W w
command Wq wq

" autochdir breaks vcs.
"set autochdir                  " Find files next to the current buffer
set autoindent
set background=dark
set backspace=indent,eol,start " Smart backspacing
set expandtab
set hidden                     " Manage multiple buffers
set history=1000               " Long history
set ignorecase                 " Ignore case in search
set incsearch                  " Incremental search
set laststatus=2               " always status line.
set mousehide                  " Hide the pointer while typing
set nocp
set nocompatible               " Use vim settings
set pastetoggle=<F2>
set ruler                      " Where am I?
set scrolloff=3                " More context around cursor
set shiftwidth=4
set shortmess=atI              " Avoid prompts
set showcmd                    " Show uncompleted commands
set showmatch                  " Show matching bracket
set smartcase                  " Do the right thing
set smarttab
set t_Co=256                   " 256 colors
set tabstop=4
set tags=tags;/                " Where to find tags
set title                      " set terminal title to filename
set tw=79                      " Text width

filetype indent on
filetype on
filetype plugin on
map <leader>t :CommandT<CR>
map <leader>T :CommandTFlush<CR>

"" Splits
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

"" Better command completion
set wildmenu
set wildmode=list:longest,full
"" Ignore these files when completing names and in Explorer
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc

syntax enable

"" Use % to match tags, if/else
runtime macros/matchit.vim

""" Keys

"" Damn you F1
map <F1> <Esc>
imap <F1> <Esc>

"" Yank to end of line
map Y y$

"" H/L was top/bottom of screen
map H ^
map L $

"" Page like a browser.
:nmap <Space> <PageDown>

"" Clear search highlight
:nmap <silent> <C-n> <Esc>:silent noh<CR>

"" Copy/paste
map ,c "+y
map ,p "+gP

"" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
au Filetype python noremap @_ va"c _(<C-r>")<Esc>F_X

""" HTML
au Filetype htmldjango,html,xml,xsl source ~/.vim/scripts/closetag.vim
