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
    Plug 'vim-vdebug/vdebug'

    " Syntax
    Plug 'aliou/bats.vim' " Bash testing
    Plug 'vim-jp/syntax-vim-ex' " Vimscript
    Plug 'rust-lang/rust.vim' " Rust
    """ Javascript
    Plug 'evanleck/vim-svelte', {'branch': 'main'} " Svelte
    Plug 'jxnblk/vim-mdx-js' " MDX
    Plug 'martin-svk/vim-yaml' " Yaml
    Plug 'yuezk/vim-js' " JSDoc
    """ TypeScript
    Plug 'Quramy/tsuquyomi'
    Plug 'leafgarland/typescript-vim'
    """ React
    Plug 'ianks/vim-tsx' " TypeScript + React
    Plug 'maxmellon/vim-jsx-pretty' " Better syntax highlighting
    """ Prisma
    Plug 'pantharshit00/vim-prisma'
    """ PHP
    Plug 'StanAngeloff/php.vim'

    " Writing plugins
    """ Dependencies manager
    Plug 'vim-jp/vital.vim'
    """ Testing framework
    Plug 'thinca/vim-themis'
    """ To make System.Job available
    Plug 'lambdalisue/vital-Whisky'

    " Tags management
    Plug 'ludovicchabant/vim-gutentags'

    " Linting
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

    " Fuzzy finders
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    " UltiSnips
    Plug 'SirVer/ultisnips'

    " Color Schemes
    Plug 'wojciechkepka/vim-github-dark'
    Plug 'cormacrelf/vim-colors-github'

    " Window/Pane management
    Plug 'blueyed/vim-diminactive'

    " Git commit messages
    Plug 'dawaa/vim-ggcommit'
call plug#end()
