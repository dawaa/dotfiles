" Remove NERDTree scrollbar and normal scrollbar
set guioptions-=L
set guioptions-=r

" NerdTree
let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
let NERDTreeIgnore=['.DS_Store', '\.swp$', '\.swo$']
let NERDTreeShowLineNumbers=1
let NERDTreeWinSize=40
let NERDTreeShowHidden=1

autocmd VimEnter * if &filetype !=# 'gitcommit' && &filetype !=# 'gitrebase' && &filetype !=# 'diff' | NERDTree | endif
