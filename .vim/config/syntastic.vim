set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 0 " Default 2
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_php_checkers             = []
let g:syntastic_scss_checkers            = []
let g:syntastic_javascript_checkers      = ['eslint']
let g:syntastic_typescript_checkers      = ['tsuquyomi']

" Override eslint with local version where necessary
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif

if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
endif
