call plug#begin('~/.vim/bundle')
    " Plug suite of autoloading functions, very nice
    " and some other plugins might depend on this.
    " Plug 'LucHermitte/lh-vim-lib'

    " Plugs
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'haya14busa/incsearch.vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'markonm/traces.vim'

    " Bash testing syntax
    Plug 'aliou/bats.vim'

    " Vimscript syntax
    Plug 'vim-jp/syntax-vim-ex'

    " Rust
    Plug 'rust-lang/rust.vim'

    " Svelte
    Plug 'evanleck/vim-svelte', {'branch': 'main'}

    " .mdx support
    Plug 'jxnblk/vim-mdx-js'

    " Writing plugins
    "  Dependencies manager
    Plug 'vim-jp/vital.vim'
    "  Testing framework
    Plug 'thinca/vim-themis'
    "  To make System.Job available
    Plug 'lambdalisue/vital-Whisky'

    " Tags management
    Plug 'ludovicchabant/vim-gutentags'

    " linting
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

    " fuzzy finders
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    " YAML indent
    Plug 'martin-svk/vim-yaml'

    " TypeScript syntax
    Plug 'Quramy/tsuquyomi'
    Plug 'leafgarland/typescript-vim'
    " Plug 'HerringtonDarkholme/yats.vim'

    " TypeScript React syntax
    Plug 'ianks/vim-tsx'

    " Javascript with JSDoc
    Plug 'yuezk/vim-js'

    " Nice syntax highlightning for react
    Plug 'maxmellon/vim-jsx-pretty'

    " UltiSnips
    Plug 'SirVer/ultisnips'

    " Color Schemes
    Plug 'wojciechkepka/vim-github-dark'
    Plug 'cormacrelf/vim-colors-github'

    " Git commit messages
    Plug 'dawaa/vim-ggcommit'
call plug#end()
