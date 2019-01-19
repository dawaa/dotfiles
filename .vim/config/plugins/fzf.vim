" Open FZF fuzzy finder in fullscreen
nnoremap <leader>F :FZF!<cr>
nnoremap <leader><Space>f :Ag<cr>
nnoremap <leader><Space>F :Ag!<cr>
nnoremap <leader>o :Buffers<cr>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Prevent opening files in NERDTree
nnoremap <silent> <expr> <C-n> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" [Tags] Command to generate tags file
" let g:fzf_tags_command = 'ctags -R'

" Augmenting Ag command using fzf#vim#with_preview function
" "   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
" "     * For syntax-highlighting, Ruby and any of the following tools are
" required:
" "       - Highlight:
" http://www.andre-simon.de/doku/highlight/en/highlight.php
" "       - CodeRay: http://coderay.rubychan.de/
" "       - Rouge: https://github.com/jneen/rouge
" "
" "   :Ag  - Start fzf with hidden preview window that can be enabled with '?' key
" "   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir FZF
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:60%:hidden', '?'), <bang>0)
