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
    use "justinmk/vim-dirvish"
    -- Readonly tree view.
    use "kyazdani42/nvim-tree.lua"

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
    use "rhysd/git-messenger.vim"
    use {
      "tpope/vim-rhubarb",
      -- Needed for opening git files on remote as I disable netrw.
      requires = {{"tyru/open-browser.vim"}}
    }

    -- Autodetect indentation.
    use "tpope/vim-sleuth"

    -- More convenient make.
    use "tpope/vim-dispatch"
    use "radenling/vim-dispatch-neovim"

    -- Matching tags.
    use "gregsexton/MatchTag"

    -- Editor config support.
    use "editorconfig/editorconfig-vim"

    -- Zen mode.
    use "junegunn/goyo.vim"

    -- Go support.
    use { "fatih/vim-go", ft = { "go" } }

    -- Tree for undo history.
    use "mbbill/undotree"

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
      requires = {{"nvim-lua/lsp-status.nvim"}}
    }
    use 'kosayoda/nvim-lightbulb'

    -- Tags/LSP symbols viewer.
    use "liuchengxu/vista.vim"

    -- Gradle compiler support.
    use "tfnico/vim-gradle"

    -- Icons.
    use "ryanoasis/vim-devicons"
    use "kyazdani42/nvim-web-devicons"

    -- Statusline.
    use "tjdevries/express_line.nvim"

    -- Markdown previewer.
    use "npxbr/glow.nvim"

    -- Better text objects.
    use "wellle/targets.vim"

    -- Snippets integration.
    use {
      "SirVer/ultisnips",
      requires = {{"honza/vim-snippets"}}
    }
    use "hrsh7th/vim-vsnip"

    -- Autopairs plugin.
    use { "windwp/nvim-autopairs", config = "require('nvim-autopairs').setup()" }

    -- Zettelkasten plugin.
    use { "oberblastmeister/neuron.nvim", branch = "unstable" }

    -- DOcumentation GEnerator.
    use "kkoomen/vim-doge"

    -- Debug utils for Vimscript.
    use "tpope/vim-scriptease"

    -- Some shims for Lua that should be eventually merged upstream.
    use "tjdevries/astronauta.nvim"
  end
}