" Override normal fast-quit mapping with gitcommit specific mapping
nnoremap <buffer> <leader>qq ggVGd:wq!<CR>
setlocal textwidth=72
setlocal colorcolumn=+1
setlocal colorcolumn+=51

map <tab> <Plug>(incsearch-stay)<++>
cmap <a-space> <cr>S

exec "normal! O<++>\n\n<++>\n\n<++>\e^qaq"

" Try grabbing the unique identifier and place it in the 'a' register
silent! %s/\v^# On branch.*##(.*)##/\=setreg('a', submatch(1))/ne

" Try replacing the third `<++>` with the unique identifier if one exists
5s/<++>/\=len(getreg('a')) ? getreg('a') : '<++>'
