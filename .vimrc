" Run the set up if found, once
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:coc_global_extensions = [
\  'coc-highlight',
\  'coc-json',
\  'coc-tsserver',
\  'coc-eslint',
\]
" \  'coc-phpls'
" \  'coc-prisma'
" \  'coc-svelte'

if filereadable(expand("~/.vim/setup.vim"))
    \ && !exists('g:loaded_vimrc')
    " Necessary to be off for cool VIM plugin things
    set nocompatible
    let g:vimrc_loaded = 1
    source ~/.vim/setup.vim
endif

" Enable OSC 52 clipboard in SSH sessions
if !empty($SSH_TTY)
  autocmd TextYankPost * call s:osc52_yank()

  function! s:osc52_yank()
    let text = join(v:event.regcontents, "\n")
    let encoded = system('base64 -w0', text)
    call writefile(["\x1b]52;c;" . encoded . "\x07"], '/dev/stderr', 'b')
  endfunction
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
