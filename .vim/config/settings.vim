" Have VIM auto reload edited files
set autoread

" Set LineNr colors
set cursorline

" Set indentations
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set copyindent
set smarttab

" Make backspace work as you would expect it to
set backspace=2

" Enable line numbers
set nu
set numberwidth=6

" Enable list command
set listchars=nbsp:†,eol:$,tab:>-,trail:~,extends:>,precedes:<

" TMUX copy paste
set clipboard=unnamed

" Vim loves to redraw the screen during things it probably doesn't
" need to - like in the middle of macros. This tells Vim to not
" bother redrawing during these scenarios, leading to faster macros
set lazyredraw

" Backups
"
" If you leave a Vim process open in which you've changed file, Vim
" creates a `backup` file. Then, when you open the file from a different
" Vim session, Vim knows to complain at you for trying to edit a file that
" is already being edited. The `backup` file is created by appending a ~ to
" the end of the file in the current directory. This can get quite annoying
" when browsing around a directory, so I applied the following settings to
" move backups to the /tmp folder.
"
" `backup` and `writebackup` enable backup support. As annoying as this can be, it
" is much better than losing tons of work in an edited-but-not-written file.
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Editing stuff in e.g. Docker containers breaks the symlink when done with Vim
" as it changes the inode number upon save. Setting `backupcopy=auto` becomes
" the middleground where Vim sees if it's possible to copy & rename without
" side-effects, if not possible, it runs with the same inode.
set backupcopy=yes

" Persistent undo
" Caveat: Must run `mkdir ~/.vim/undo`
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

" Allow to switch buffer even though current buffer has unsaved work.
set hidden

" Allow vim to actually full-screen a pane without leaving
" leaving current line only showing in the minized pane.
" This however leaves only the filename still showing, which is nice.
set wmh=0

set belloff=all

autocmd ColorScheme *
    \ hi CocUnusedHighlight ctermbg=NONE guibg=NONE guifg=#808080

" Performance optimizations for large files
" Limit syntax highlighting to first 500 columns (prevents slowdown on long lines)
set synmaxcol=500
" Limit time spent on syntax highlighting (prevents hangs on complex syntax)
set redrawtime=10000
" Limit memory for pattern matching
set maxmempattern=2000

" Automatically disable features for large files (> 10MB)
autocmd BufReadPre *
    \ let f=getfsize(expand("<afile>"))
    \ | if f > 10485760 || f == -2
    \ | syntax off
    \ | setlocal eventignore+=FileType
    \ | setlocal noswapfile
    \ | setlocal bufhidden=unload
    \ | setlocal undolevels=-1
    \ | echo "Large file detected - features disabled for performance"
    \ | endif

" Faster terminal performance
set ttyfast

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Better command-line completion
set wildmenu
set wildmode=longest:full,full

" Show partial commands
set showcmd

" Keep cursor away from screen edges (better context)
set scrolloff=5
set sidescrolloff=5

" More natural split behavior
set splitbelow
set splitright

" Faster CoC updates (default 4000ms is too slow)
set updatetime=300

" Faster key mapping timeouts
set timeoutlen=500
set ttimeoutlen=10

" Prevent screen jumping when signs appear/disappear
set signcolumn=yes
