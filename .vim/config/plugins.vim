call vundle#begin()
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Plugins
    Plugin 'vim-airline/vim-airline'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'tpope/vim-surround'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'digitaltoad/vim-pug'
    Plugin 'mileszs/ack.vim'
    Plugin 'ntpeters/vim-better-whitespace'
    Plugin 'haya14busa/incsearch.vim'
    Plugin 'junegunn/vim-easy-align'
    Plugin 'scrooloose/nerdcommenter'

    " fuzzy finders
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    " Plugin 'ctrlpvim/ctrlp.vim'

    " YAML indent
    Plugin 'martin-svk/vim-yaml'

    " TypeScript syntax
    Plugin 'Quramy/tsuquyomi'
    Plugin 'leafgarland/typescript-vim'
    " Plugin 'HerringtonDarkholme/yats.vim'

    " TypeScript React syntax
    Plugin 'ianks/vim-tsx'

    " Javascript with JSDoc
    Plugin 'pangloss/vim-javascript'
    " Plugin 'othree/es.next.syntax.vim'

    " Nice syntax highlightning for react
    Plugin 'mxw/vim-jsx' " dependency: pangloss/vim-javascript

    " UltiSnips
    Plugin 'SirVer/ultisnips'

    " LiveScript
    Plugin 'gkz/vim-ls'

    " Color Schemes
    Plugin 'chriskempson/base16-vim'
    Plugin 'rhysd/vim-color-spring-night'
call vundle#end()

" This allows for locally setting options per file types
filetype plugin indent on
syntax on
