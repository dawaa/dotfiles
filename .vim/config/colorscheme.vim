" Set 256 colors
set t_Co=256
" set term=screen-256color

" Enable color scheme and syntax
" colo gruvbox
syntax on

" set gruvbox dark theme
" set background=dark

" Set background to NONE
hi Normal guibg=NONE ctermbg=NONE

" Set colorcolumn
set cc=80

" Set line colors upon VimEnter
autocmd VimEnter * highlight LineNr guifg=#68899a guibg=#263238
autocmd VimEnter * highlight CursorLineNr guifg=#FFFFFF guibg=#263238 gui=NONE

if filereadable( expand( "~/.vimrc_background" ) )
    let base16colorspace=256
    source ~/.vimrc_background
endif

