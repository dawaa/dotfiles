call vundle#begin()
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Plugins
    Plugin 'tpope/vim-fugitive'
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

    " fuzzy finders
    " Plugin 'ctrlpvim/ctrlp.vim'

    " These two are coupled together
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'tpope/vim-dispatch' " Useful to open quick tasks with

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

    " Color Schemes
    Plugin 'mkarmona/colorsbox'
    Plugin 'easysid/mod8.vim'
    Plugin 'gwutz/vim-materialtheme'
    Plugin 'w0ng/vim-hybrid'
    Plugin 'YorickPeterse/happy_hacking.vim'
    Plugin 'junegunn/seoul256.vim'
    Plugin 'morhetz/gruvbox'
    Plugin 'rhysd/vim-color-spring-night'
    Plugin 'chriskempson/base16-vim'
call vundle#end()

" This allows for locally setting options per file types
filetype plugin indent on
syntax on
