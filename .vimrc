" Run the set up if found, once
if filereadable(expand("~/.vim/setup.vim"))
    \ && !exists('g:loaded_vimrc')
    " Necessary to be off for cool VIM plugin things
    set nocompatible
    let g:loaded_vimrc = 1
    source ~/.vim/setup.vim
endif

runtime! mappings/*
