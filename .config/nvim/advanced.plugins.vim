" Handful shortcuts for *nix commands.
Plug 'tpope/vim-eunuch'

" Autocompletion engine utilizing LSP from VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Additional syntax support
Plug 'sheerun/vim-polyglot'

" Explorer that adheres to Vim philosophy.
Plug 'justinmk/vim-dirvish'

" Fuzzy search for everything.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

" Git plugin.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Autodetect indentation.
Plug 'tpope/vim-sleuth'

" More convenient make.
Plug 'tpope/vim-dispatch'

" Matching tags.
Plug 'gregsexton/MatchTag'

" Editor config support.
Plug 'editorconfig/editorconfig-vim'

" Zen mode.
Plug 'junegunn/goyo.vim'

" Go support.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
