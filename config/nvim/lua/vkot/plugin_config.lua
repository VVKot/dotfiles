local packer = require("packer")
packer.init({ max_jobs = 50 })

return packer.startup({
  function(use)
    -- Manage packer itself.
    use({ "wbthomason/packer.nvim", opt = true })
    -- Sensible defaults.
    use("tpope/vim-sensible")
    -- Comments.
    use("tpope/vim-commentary")
    -- Add/remove/change surroundings.
    use("tpope/vim-surround")
    -- Useful pair-wise mappings.
    use("tpope/vim-unimpaired")
    -- Repeat plugin commands.
    use("tpope/vim-repeat")
    -- Simplifies working with variants of the word.
    use("tpope/vim-abolish")
    -- Handful shortcuts for *nix commands.
    use("tpope/vim-eunuch")
    -- Autodetect indentation.
    use("tpope/vim-sleuth")
    -- Debug utils for Vimscript.
    use("tpope/vim-scriptease")
    -- Exchange two motions.
    use("tommcdo/vim-exchange")

    -- Matching tags.
    use("gregsexton/MatchTag")
    -- Editor config support.
    use("editorconfig/editorconfig-vim")
    -- Better text objects.
    use("wellle/targets.vim")
    -- Autopairs plugin.
    use("windwp/nvim-autopairs")

    -- Neovim LSP.
    use("neovim/nvim-lspconfig")
    -- Docker images for LSP servers.
    use("lspcontainers/lspcontainers.nvim")
    -- Go support.
    use("fatih/vim-go")
    -- Diagnostics.
    use("dense-analysis/ale")

    -- Syntax highlighting.
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("romgrk/nvim-treesitter-context")

    -- Explorer that adheres to Vim philosophy.
    use("justinmk/vim-dirvish")
    -- Tree for undo history.
    use("mbbill/undotree")
    -- Fancy start screen.
    use("mhinz/vim-startify")

    -- Git plugins.
    use("tpope/vim-fugitive")
    use({
      "tpope/vim-rhubarb",
      -- Needed for opening git files on remote as I disable netrw.
      requires = { { "tyru/open-browser.vim" } },
    })
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use("rhysd/conflict-marker.vim")
    -- Git commit browser.
    use("junegunn/gv.vim")

    -- Lua-based fuzzy search.
    use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-ui-select.nvim" })
    -- Icons.
    use("ryanoasis/vim-devicons")
    use("kyazdani42/nvim-web-devicons")

    -- Zettelkasten plugin.
    use({ "oberblastmeister/neuron.nvim", branch = "unstable" })
  end,
})
