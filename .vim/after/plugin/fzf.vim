" Open FZF fuzzy finder in fullscreen
nnoremap <leader>F :FZF<cr>
nnoremap <leader><Space>f :Rg<cr>
nnoremap <leader><Space>F :Rg!<cr>
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>t :Tags<cr>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

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
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \     'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \     <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \             : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \     <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir FZF
  \ call fzf#vim#files(
  \     <q-args>,
  \     fzf#vim#with_preview('right:60%:hidden', '?'), <bang>0)
