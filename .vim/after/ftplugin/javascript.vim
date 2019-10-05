setlocal shiftwidth=2
setlocal tabstop=2
setlocal textwidth=80
setlocal colorcolumn=+1

" Enable JSDoc syntax highlight
let g:javascript_plugin_jsdoc = 1

" This should fix the end tags color diff from starting tags in .jsx files
hi Tag          ctermfg=04
hi xmlTag       ctermfg=04
hi xmlTagName   ctermfg=04
hi xmlEndTag    ctermfg=04
