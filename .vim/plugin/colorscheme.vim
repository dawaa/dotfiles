" Set 256 colors
set t_Co=256
set t_ut=
set termguicolors

" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" set term=screen-256color
syntax on

let g:gh_color = 'soft'
set background=dark
colorscheme ghdark

function! SetupLightColorScheme() abort
    set background=light
    """ Set Tab colors
    hi TabLineSel guifg=#ffffff guibg=#fa7970
endfunction

function! SetupDarkColorScheme() abort
    set background=dark
    hi ColorColumn guibg=#21262d
endfunction

augroup MyColors
    autocmd!
    autocmd colorscheme github call SetupLightColorScheme()
    autocmd colorscheme ghdark call SetupDarkColorScheme()
augroup END

" Match `CursorLine` of `ghdark`
hi ColorColumn guibg=#21262d

""" Set Tab colors
hi TabLineSel guifg=#ffffff guibg=#fa7970

autocmd VimEnter * match Error /\%xA0/
