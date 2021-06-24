" Override normal fast-quit mapping with gitcommit specific mapping
nnoremap <buffer> <leader>qq ggVGd:wq!<CR>
setlocal textwidth=72
setlocal colorcolumn=+1
setlocal colorcolumn+=51

map <expr> <tab> (getline('.') =~ '<++>' ? '<Plug>(incsearch-stay)<++>' : '<Plug>(incsearch-forward)<++>')
cnoremap <expr> <space> (getline('.') =~ '<++>' ? '<cr>S' : '<space>')
imap <c-j> <esc><Plug>(incsearch-forward)<++>

let g:ggcommit_pre_wrapper = '--'
let g:ggcommit_post_wrapper = '--'
