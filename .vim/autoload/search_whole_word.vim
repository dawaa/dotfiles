function! SearchWholeWord(word)
    let @/ = '\<' . a:word . '\>'
    normal n
endfunction

command! -nargs=1 SearchExactWord call SearchWholeWord(<f-args>)
