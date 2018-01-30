"" Highlight unused imports, first saves, clears previous matches
" nnoremap <leader>ji :w<CR>:call clearmatches()<CR>:let cmd = system('unused -v true ' . expand('%'))<CR>:exec cmd<CR>"

" Enable JSDoc syntax highlight
let g:javascript_plugin_jsdoc = 1

" This should fix the end tags color diff from starting tags in .jsx files
hi Tag          ctermfg=04
hi xmlTag       ctermfg=04
hi xmlTagName   ctermfg=04
hi xmlEndTag    ctermfg=04
