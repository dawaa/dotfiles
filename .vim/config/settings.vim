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

" Persistent undo
" Caveat: Must run `mkdir ~/.vim/undo`
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000
