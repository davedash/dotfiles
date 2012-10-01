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

call pathogen#infect()
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
colorscheme asu1dark

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

""" Python
map <F8> Oimport pdb; pdb.set_trace()<Esc>
autocmd FileType python set tw=79 cc=+1 ts=4 shiftwidth=4 fdm=indent fdl=10
"" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
au Filetype python noremap @_ va"c _(<C-r>")<Esc>F_X

""" PHP
autocmd FileType php set tw=0

""" DjangoTemplates
au BufNewFile,BufRead *.txt set filetype=htmldjango
autocmd FileType xhtml,html,txt set ft=htmldjango
autocmd FileType html set sw=2
autocmd FileType htmldjango setlocal sw=2 ts=2
au Filetype htmldjango vnoremap @_ c{{ _('<C-r>"') }}<Esc>
au Filetype htmldjango noremap @_ vt<c{{ _('<C-r>"') }}<Esc>

""" Sphinx
let @h = "yypVr"

""" HTML
au Filetype htmldjango,html,xml,xsl source ~/.vim/scripts/closetag.vim

<<<<<<< HEAD
=======
<<<<<<< HEAD
""" Puppet
au BufNewFile,BufRead *.pp set filetype=puppet
au Filetype puppet set sw=2
=======
>>>>>>> 9c623dd1755220c79ce7de54063266cfb6a93e53
>>>>>>> Edit puppet files.
