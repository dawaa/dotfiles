" Run the set up if found, once
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if filereadable(expand("~/.vim/setup.vim"))
    \ && !exists('g:loaded_vimrc')
    " Necessary to be off for cool VIM plugin things
    set nocompatible
    let g:vimrc_loaded = 1
    source ~/.vim/setup.vim
endif

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif
let g:vdebug_options.port = 9999
let g:vdebug_options.break_on_open = 0
let g:vdebug_options.debug_file_level = 2
let g:vdebug_options.debug_file = '~/vdebug.log'
let g:vdebug_options.path_maps = {
\  '/app': getcwd()
\}
if !exists('g:vdebug_features')
    let g:vdebug_features = {}
endif
let g:vdebug_features = {
\  'max_children': 128
\}

runtime! mappings/*
