" Handful shortcuts for *nix commands.
Plug 'tpope/vim-eunuch'

" Autocompletion engine utilizing LSP from VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Additional syntax support
Plug 'sheerun/vim-polyglot'

" Tree plugin.
Plug 'preservim/nerdtree'
" Alternative explorer plugin
Plug 'justinmk/vim-dirvish'

" Fuzzy search for everything.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

" Git plugin.
Plug 'tpope/vim-fugitive'

" Autodetect indentation.
Plug 'tpope/vim-sleuth'

" More convenient make.
Plug 'tpope/vim-dispatch'

" Matching tags.
Plug 'gregsexton/MatchTag'

" Editor config support.
Plug 'editorconfig/editorconfig-vim'

" Gradle compiler support.
Plug 'tfnico/vim-gradle'

" Zen mode.
Plug 'junegunn/goyo.vim'
