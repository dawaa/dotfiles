" Rip Grep
if executable('rg')
  " Use `rg` over grep
  set grepprg=rg
endif

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!

nnoremap \ :Rg<space>
