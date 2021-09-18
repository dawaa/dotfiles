" Set 256 colors
set t_Co=256
" set term=screen-256color
syntax on

" Set background to NONE
hi Normal guibg=NONE ctermbg=NONE

" Set line colors upon VimEnter
autocmd VimEnter * highlight LineNr guifg=#68899a guibg=#263238
autocmd VimEnter * highlight CursorLineNr guifg=#FFFFFF guibg=#263238 gui=NONE


autocmd VimEnter * match Error /\%xA0/
