" function !SearchWholeWord(word)
"     let @/ = '\<' . a:word . '\>'
"     normal n
" endfunction
" 
" command! -nargs=1 SearchWord call SearchWholeWord(<f-args>)
" nmap ? :SearchWord 
