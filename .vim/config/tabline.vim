" Use non GUI tabs
set guioptions-=e

" Change tabline settings
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let t = tabpagenr()
        let i = 1

        let mem = []
        let dup = []
        let j = 1
        while j <= tabpagenr('$')
            let buflist = tabpagebuflist(j)
            let winnr   = tabpagewinnr(j)
            let name    = bufname( buflist[ winnr - 1 ] )
            let name    = fnamemodify( name, ':p:t' )

            " If `name` is found in `mem`
            if index( mem, name ) != -1

                " If `name` doesn't yet exist in `dup`, add it
                if index( dup, name ) == -1
                    let dup = add( dup, name )
                endif
            endif

            " Save `name` to `mem`
            let mem = add( mem, name )

            " Increment `j`
            let j = j + 1
        endwhile

        " Check while i is under last tab page nr
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)

            " Set the tab page number ( mouse clicks )
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let s .= i
            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let fileBuf = bufname(buflist[winnr - 1])
            let file    = fnamemodify(fileBuf, ':p:t')

            if index( dup, file ) != -1
                let file = fnamemodify(fileBuf, ':r')
            endif

            " if i == t
            "     let file = fnamemodify(file, ':r')
            " else
            "     let file = fnamemodify(file, ':p:t')
            " endif

            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    " Show tabline always
    set stal=2
    set tabline=%!MyTabLine()
endif

