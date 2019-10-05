" @TODO doesn't work yet
autocmd BufEnter,BufWrite * match Error /\%xA0/
autocmd VimEnter * :so ~/.vimrc
