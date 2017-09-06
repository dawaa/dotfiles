call vundle#begin()
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Plugins
    Plugin 'tpope/vim-fugitive'
    Plugin 'vim-airline/vim-airline'
    Plugin 'scrooloose/nerdtree'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'tpope/vim-surround'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'digitaltoad/vim-pug'
    Plugin 'mileszs/ack.vim'
    Plugin 'ntpeters/vim-better-whitespace'

    " Javascript with JSDoc
    Plugin 'pangloss/vim-javascript'

    " Nice syntax highlightning for react
    Plugin 'mxw/vim-jsx'

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

filetype plugin indent on
syntax on
