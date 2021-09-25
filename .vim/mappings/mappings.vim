" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>qq :q!<cr>

" Fast open up vimrc in a new tab
map <leader>vrc :e ~/.vimrc<cr>

" Fast search
nmap <leader><leader>f /
" Insensitive search
nmap <leader><leader>F /\c

" Enable / disable transparency
nmap <leader><leader>l :set list<CR>
nmap <leader><leader>L :set nolist<CR>

" Reload vimrc
nnoremap <leader>R :so ~/.vimrc<CR>

" Last active tab
let g:lasttab = 1
nmap <leader><leader>. :exe "tabn ".g:lasttab<CR>
nmap <leader><leader><Space> :b#<cr>
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

" Quick pane-resizing
nnoremap <leader><C-J> 10<C-W>+
nnoremap <leader><C-K> 10<C-W>-
nnoremap <leader><C-H> 10<C-W>>
nnoremap <leader><C-L> 10<C-W><

" Quick create panes
nnoremap <leader>% :vsplit<cr>
nnoremap <leader>" :split<cr>

" Disable the word-lookup functionality
nnoremap K <Nop>

" Unmaps å to call an Auto Pair function
let g:AutoPairsShortcutFastWrap=''

inoremap <silent> <Plug>snipMateNextOrTrigger <C-R>=snipMate#TriggerSnippet()

" Clean trailing whitespace
nnoremap <leader>= :%s/\s\+$//<cr>:let @/=''<cr>
" Let the weird space be!!!
nnoremap <leader><leader>= :%s/ / /<cr>

" Sourcing
vnoremap <leader>S y:execute @@<cr>

" Open current dir in Finder
nnoremap <leader>O :!open .<cr>

" Set up tag find, because it was apparently not set
nnoremap <leader>x <C-]>

" Map search to use haya14busa/incsearch.vim
map ; <Plug>(incsearch-forward)
map / /

" Disables the possibility of typing a 'non-breaking space'
imap <A-Space> <Space>

" Toggle Syntastic
nnoremap <leader>lt :SyntasticToggleMode<cr>

" filename completion
inoremap <c-f> <c-x><c-f>

vmap <leader>f  <Plug>(coc-format-selected)

" Quickly re-select last shape rather than last _actual_ selection
noremap gV `[v`]

nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename) " Symbol renaming

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
