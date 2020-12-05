return require('packer').startup {
  function(use)
    -- Sensible defaults.
    use "tpope/vim-sensible"
    -- Comments.
    use "tpope/vim-commentary"
    -- Add/remove/change surroundings.
    use "tpope/vim-surround"
    -- Useful pair-wise mappings.
    use "tpope/vim-unimpaired"
    -- Repeat plugin commands.
    use "tpope/vim-repeat"
    -- Simplifies working with variants of the word.
    use "tpope/vim-abolish"
    -- Exchange two motions.
    use "tommcdo/vim-exchange"
    -- Handful shortcuts for *nix commands.
    use "tpope/vim-eunuch"

    -- Autocompletion engine utilizing LSP from VSCode.
    use { "neoclide/coc.nvim", branch = "release" }

    -- Explorer that adheres to Vim philosophy.
    use "justinmk/vim-dirvish"
    -- Readonly tree view.
    use "kyazdani42/nvim-tree.lua"

    -- Fuzzy search for everything.
    use "/usr/local/opt/fzf"
    use "junegunn/fzf.vim"
    use { "antoinemadec/coc-fzf", branch = "release" }

    -- Lua-based fuzzy search.
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    -- Git plugins.
    use "tpope/vim-fugitive"
    use "tpope/vim-rhubarb"
    use "rhysd/git-messenger.vim"

    -- Autodetect indentation.
    use "tpope/vim-sleuth"

    -- More convenient make.
    use "tpope/vim-dispatch"

    -- Matching tags.
    use "gregsexton/MatchTag"

    -- Editor config support.
    use "editorconfig/editorconfig-vim"

    -- Zen mode.
    use "junegunn/goyo.vim"

    -- Go support.
    use { "fatih/vim-go", run = ":GoUpdateBinaries" }

    -- Tree for undo history.
    use "mbbill/undotree"

    -- Fancy start screen.
    use "mhinz/vim-startify"

    -- Syntax highlighting.
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "nvim-treesitter/nvim-treesitter-refactor"
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Neovim LSP.
    use "neovim/nvim-lspconfig"
    use "nvim-lua/completion-nvim"
    use "nvim-lua/lsp-status.nvim"
    use "nvim-treesitter/completion-treesitter"

    -- Gradle compiler support.
    use "tfnico/vim-gradle"

    -- Lua scratchpad.
    use "rafcamlet/nvim-luapad"

    -- Icons.
    use "ryanoasis/vim-devicons"
    use "kyazdani42/nvim-web-devicons"

    -- Statusline.
    use "tjdevries/express_line.nvim"

    -- Markdown previewer.
    use "npxbr/glow.nvim"
  end
}
