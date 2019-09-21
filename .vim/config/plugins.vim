call vundle#begin()
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Plugin suite of autoloading functions, very nice
    " and some other plugins might depend on this.
    " Plugin 'LucHermitte/lh-vim-lib'

    " Plugins
    Plugin 'vim-airline/vim-airline'
    Plugin 'scrooloose/nerdtree'
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

    " Bash testing syntax
    Plugin 'aliou/bats.vim'

    " Vimscript syntax
    Plugin 'vim-jp/syntax-vim-ex'
    " CoffeeScript syntax
    Plugin 'kchmck/vim-coffee-script'

    " Writing plugins
    "  Dependencies manager
    Plugin 'vim-jp/vital.vim'
    "  Testing framework
    Plugin 'thinca/vim-themis'
    "  To make System.Job available
    Plugin 'lambdalisue/vital-Whisky'

    " Tags management
    Plugin 'ludovicchabant/vim-gutentags'

    " linting
    " Plugin 'vim-syntastic/syntastic'
    Plugin 'w0rp/ale'

    " fuzzy finders
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'

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
    " When doing git diffs
    Plugin 'albertorestifo/github.vim'
call vundle#end()

" This allows for locally setting options per file types
filetype plugin indent on
syntax on
