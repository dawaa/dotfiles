setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab

nnoremap <leader>.j :%s/\(\w\+\):/"\1":/g<cr>:%s/'\(.*\)'/"\1"/g<cr>:%s/\v,\n*(\s*})/\r\1/g<cr>ggVG=
" :%s/'\(.*\)'/"\1"/g
" :%s/\v\(\w+:\)/"\1":/g
