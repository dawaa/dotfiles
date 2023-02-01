" Run the set up if found, once
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:OmniSharp_server_use_net6 = 1

if filereadable(expand("~/.vim/setup.vim"))
    \ && !exists('g:loaded_vimrc')
    " Necessary to be off for cool VIM plugin things
    set nocompatible
    let g:vimrc_loaded = 1
    source ~/.vim/setup.vim
endif

runtime! mappings/*
