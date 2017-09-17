let s:matches_found = []

function! s:find_import_statements()
    " Clear out any matches
    " call s:reset_found_imports()

    highlight unused_es6_imports ctermbg=yellow guibg=yellow

    " Save current position
    let startLine = line( '.' )
    let startCol  = col( '.' )

    let lineNr = 0

    " Start off at the very top
    call cursor( 1, 1 )

    " Define when a class or function starts
    let codeStartRgx = '\v(^import\s\w+\sfrom)@<!(<class>|<function>|<var>|<let>|<const>)'
    let codeLine  = search( codeStartRgx )

    " From 1,1 we go all the way down to when `codeLine`-line no starts
    while lineNr < codeLine
        let lineNr += 1 " Keep looking line by line
        let line    = getline( lineNr )

        "let importRgx = "\v%(^import\s(\w+)\sfrom\s.*)"
        let importRgx = '\vimport\s(test)\sfrom\s.*'
        let matches   = matchlist( line, importRgx )

        " If we found imports
        if len( matches ) > 0
            let importConst = matches[ 1 ]

            " Switch cursor position to where `codeLine` starts
            call cursor( codeLine, 1 )

            " Search for import usage throughout the file
            let searchRgx = '\v(//.*)@<!' . importConst . '\(.*\)'
            let importUsageFound = search( searchRgx, 'n' )

            echom "Import usage found::: " . importUsageFound

            if importUsageFound == 0
                echom "Couldn't find any import usages of '" . importConst . "'"
                call add( s:matches_found, matchadd( 'unused_es6_imports', '^' . line . '$' ) )
            endif
        endif
    endwhile

    echom len(s:matches_found)
    echom s:matches_found[0]
    " echom get(s:matches_found[-1])
    call matchdelete(s:matches_found[0])

    " Reset cursor position
    call cursor( startLine, startCol )
endfunction

function! s:reset_found_imports()
    echom len(s:matches_found)
    for id in s:matches_found
        call matchdelete( id )
    endfor

    echom "meow"
    let s:matches_found = []
endfunction

command! FindImports call s:find_import_statements()
command! ClearFoundImports call s:reset_found_imports()
