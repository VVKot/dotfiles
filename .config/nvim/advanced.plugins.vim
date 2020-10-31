" Handful shortcuts for *nix commands.
Plug 'tpope/vim-eunuch'

" Autocompletion engine utilizing LSP from VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Explorer that adheres to Vim philosophy.
Plug 'justinmk/vim-dirvish'

" Fuzzy search for everything.
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" Git plugins.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rhysd/git-messenger.vim'

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

" Tree for undo history.
Plug 'mbbill/undotree'

" Session management.
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" Syntax highlighting.
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Neovim LSP.
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-treesitter/completion-treesitter'

" Gradle compiler support.
Plug 'tfnico/vim-gradle'
