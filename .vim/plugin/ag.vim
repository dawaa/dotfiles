" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Agc silent! grep! <args>|cwindow|redraw!

nnoremap \ :Agc<space>
