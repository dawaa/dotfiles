" YouCompleteMe and UltiSnips compatability
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

" Prevent UltiSnips from removing our carefully-crafted mappings
let g:UltiSnipsMappingToIgnore = ['autocomplete']

" Set UltiSnips directories
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = [$HOME . '/.vim/ultisnips']

" Open UltiSnips edit vertically
let g:UltiSnipsEditSplit = 'vertical'

" Let it know which python version we be using
" let g:UltiSnipsUsePythonVersion = 3

" Open edit quick n cool
nmap <leader>E :UltiSnipsEdit<cr>

if has('autocmd')
    augroup WincentAutocomplete
        autocmd!
        autocmd! User UltiSnipsEnterFirstSnippet
        autocmd User UltiSnipsEnterFirstSnippet call autocomplete#setup_mappings()
        autocmd! User UltiSnipsExitLastSnippet
        autocmd User UltiSnipsExitLastSnippet call autocomplete#teardown_mappings()
    augroup END
endif
