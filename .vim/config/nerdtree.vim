" Remove NERDTree scrollbar and normal scrollbar
set guioptions-=L
set guioptions-=r

" NerdTree
let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
let NERDTreeIgnore=['.DS_Store', '\.swp$']
let NERDTreeShowLineNumbers=1
let NERDTreeWinSize=40

autocmd vimenter * NERDTree
