return require("packer").startup {
  function(use)
    -- Manage packer itself.
    use {"wbthomason/packer.nvim", opt = true}
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
    use { "justinmk/vim-dirvish", cmd = "Dirvish" }
    -- Readonly tree view.
    use { "kyazdani42/nvim-tree.lua", cmd = { "NvimTreeOpen", "NvimTreeToggle" } }

    -- Fuzzy search for everything.
    use "/usr/local/opt/fzf"
    use "junegunn/fzf.vim"
    use { "antoinemadec/coc-fzf", branch = "release" }

    -- Lua-based fuzzy search.
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
    }

    -- Git plugins.
    use "tpope/vim-fugitive"
    use { "rhysd/git-messenger.vim", cmd = "GitMessenger" }
    use {
      "tpope/vim-rhubarb",
      -- Need for opening git file on remote.
      requires = {{"tyru/open-browser.vim"}},
      config = "vim.cmd[[command! -nargs=1 Browse OpenBrowser <args>]]"
    }

    -- Autodetect indentation.
    use "tpope/vim-sleuth"

    -- More convenient make.
    use "tpope/vim-dispatch"

    -- Matching tags.
    use "gregsexton/MatchTag"

    -- Editor config support.
    use "editorconfig/editorconfig-vim"

    -- Zen mode.
    use { "junegunn/goyo.vim", cmd = "Goyo" }

    -- Writing tools.
    use { "dbmrq/vim-ditto", cmd = "Ditto" }
    use "reedes/vim-wordy"

    -- Go support.
    use { "fatih/vim-go", ft = { "go" }, run = ":GoUpdateBinaries" }

    -- Tree for undo history.
    use { "mbbill/undotree", cmd = { "UndotreeShow", "UndotreeToggle" } }

    -- Fancy start screen.
    use "mhinz/vim-startify"

    -- Syntax highlighting.
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        {"nvim-treesitter/nvim-treesitter-refactor"},
        {"nvim-treesitter/nvim-treesitter-textobjects"},
        {"nvim-treesitter/completion-treesitter"}
      }
    }

    -- Neovim LSP.
    use {
      "neovim/nvim-lspconfig",
      requires = {{"nvim-lua/completion-nvim"},{"nvim-lua/lsp-status.nvim"}}
    }

    -- Gradle compiler support.
    use "tfnico/vim-gradle"

    -- Icons.
    use "ryanoasis/vim-devicons"
    use "kyazdani42/nvim-web-devicons"

    -- Statusline.
    use "tjdevries/express_line.nvim"

    -- Markdown previewer.
    use { "npxbr/glow.nvim", cmd = "Glow" }

    -- Better text objects.
    use "wellle/targets.vim"

    use {
      "SirVer/ultisnips",
      requires = {{"honza/vim-snippets"}}
    }

    -- Autopairs plugin.
    use { "windwp/nvim-autopairs", config = "require('nvim-autopairs').setup()" }
  end
}
