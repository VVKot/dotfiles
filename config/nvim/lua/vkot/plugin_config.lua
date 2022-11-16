-- Temporary hack until https://github.com/neovim/neovim/issues/15176 is resolved
vim.cmd([[set background=light]])

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
    -- Exchange two motions.
    use("tommcdo/vim-exchange")
    -- Handful shortcuts for *nix commands.
    use("tpope/vim-eunuch")

    -- Completion for native LSP.
    use("onsails/lspkind-nvim")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("quangnguyen30192/cmp-nvim-ultisnips")

    -- Explorer that adheres to Vim philosophy.
    use("justinmk/vim-dirvish")
    use("bounceme/remote-viewer")
    -- Readonly tree view.
    use("kyazdani42/nvim-tree.lua")

    -- Fuzzy search for everything.
    use("junegunn/fzf")
    use("junegunn/fzf.vim")

    -- Lua-based fuzzy search.
    use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-ui-select.nvim" })

    -- Git plugins.
    use("tpope/vim-fugitive")
    use("rhysd/git-messenger.vim")
    use({
      "tpope/vim-rhubarb",
      -- Needed for opening git files on remote as I disable netrw.
      requires = { { "tyru/open-browser.vim" } },
    })
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use("rhysd/conflict-marker.vim")
    -- Git commit browser.
    use("junegunn/gv.vim")
    use("theprimeagen/git-worktree.nvim")

    -- Autodetect indentation.
    use("tpope/vim-sleuth")

    -- More convenient make.
    use("tpope/vim-dispatch")
    use("radenling/vim-dispatch-neovim")

    -- Matching tags.
    use("gregsexton/MatchTag")

    -- Editor config support.
    use("editorconfig/editorconfig-vim")

    -- Zen mode.
    use({ "folke/zen-mode.nvim" })
    use("preservim/vim-pencil")

    -- Go support.
    use("fatih/vim-go")

    -- Tree for undo history.
    use("mbbill/undotree")

    -- Fancy start screen.
    use("mhinz/vim-startify")

    -- Syntax highlighting.
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("romgrk/nvim-treesitter-context")

    -- Neovim LSP.
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/nvim-lsp-ts-utils")

    -- Icons.
    use("ryanoasis/vim-devicons")
    use("kyazdani42/nvim-web-devicons")

    -- Statusline.
    use("nvim-lualine/lualine.nvim")

    -- Better text objects.
    use("wellle/targets.vim")

    -- Snippets integration.
    use({
      "SirVer/ultisnips",
      requires = { { "honza/vim-snippets", rtp = "." } },
      config = function()
        vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
        vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
        vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
        vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
        vim.g.UltiSnipsRemoveSelectModeMappings = 0
      end,
    })
    use("fhill2/telescope-ultisnips.nvim")

    -- Autopairs plugin.
    use("windwp/nvim-autopairs")

    -- Zettelkasten plugin.
    use({ "oberblastmeister/neuron.nvim", branch = "unstable" })

    -- DOcumentation GEnerator.
    use("kkoomen/vim-doge")

    -- Debug utils for Vimscript.
    use("tpope/vim-scriptease")

    -- Testing.
    use("vim-test/vim-test")

    -- Utils to quick navigate to & reuse terminals.
    use("ThePrimeagen/harpoon")

    -- Show all available keymaps.
    use({ "folke/which-key.nvim" })

    -- Docker images for LSP servers.
    use("lspcontainers/lspcontainers.nvim")

    -- Gradle support.
    use("tfnico/vim-gradle")

    -- Support for remote copy-paste.
    use("ojroques/vim-oscyank")

    -- Cache lua modules for quicker startup.
    use("lewis6991/impatient.nvim")

    -- Server installation.
    use("williamboman/nvim-lsp-installer")
  end,
})
