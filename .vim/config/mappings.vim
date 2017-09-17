" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>qq :q!<cr>

" Fast open up vimrc in a new tab
map <leader>vrc :tabe ~/.vimrc<cr>

" Fast search
nmap <leader><leader>f /
" Insensitive
nmap <leader><leader>F /\c

" Enable / disable transparency
nmap <leader><leader>l :set list<CR>
nmap <leader><leader>L :set nolist<CR>

" Reload vimrc
nnoremap <leader>R :so ~/.vimrc<CR>

" Last active tab
let g:lasttab = 1
nmap <leader><leader><Space> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Quick n easy tab-switching prev/next
nmap tb :tabp<CR>
vmap tb :tabp<CR>
nmap tn :tabn<CR>
vmap tn :tabn<CR>
" Move around tabs
map <leader>tm :tabmove
" NerdTree toggle
map <C-n> :NERDTreeTabsToggle<CR>
" ?
nmap <silent> <A-Up> <C-w> k<CR>
nmap <silent> <A-Down> <C-w> j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Quick pane-switching in Vim
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nnoremap K k
inoremap å j
inoremap <silent> <Plug>snipMateNextOrTrigger <C-R>=snipMate#TriggerSnippet()

" Window resizing
" nnoremap <c-left> 5<c-w>>
" nnoremap <c-right> 5<c-w><
nnoremap <D-k> k
