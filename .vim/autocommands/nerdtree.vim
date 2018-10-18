augroup ps_nerdtree
    au!

    au FileType nerdtree setlocal nolist
    au FileType nerdtree noremap <buffer> H :vertical resize -10<cr>
    au FileType nerdtree noremap <buffer> L :vertical resize +10<cr>
augroup END

