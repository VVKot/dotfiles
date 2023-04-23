local lazy = require("lazy")

local plugins = {
  -- Manage packer itself.
  { "wbthomason/packer.nvim", opt = true },
  -- Sensible defaults.
  "tpope/vim-sensible",
  -- Comments.
  "tpope/vim-commentary",
  -- Add/remove/change surroundings.
  "tpope/vim-surround",
  -- Useful pair-wise mappings.
  "tpope/vim-unimpaired",
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- Repeat plugin commands.
  "tpope/vim-repeat",
  -- Simplifies working with variants of the word.
  "tpope/vim-abolish",
  -- Handful shortcuts for *nix commands.
  "tpope/vim-eunuch",
  -- Debug utils for Vimscript.
  "tpope/vim-scriptease",
  -- Exchange two motions.
  "tommcdo/vim-exchange",
  -- Minimal plugins for other things
  "echasnovski/mini.nvim",

  -- Neovim LSP.
  "neovim/nvim-lspconfig",
  -- Additional lua configuration for plugin interactions
  "folke/neodev.nvim",
  -- Docker images for LSP servers.
  "lspcontainers/lspcontainers.nvim",
  -- Go support.
  "fatih/vim-go",
  -- Diagnostics.
  "dense-analysis/ale",

  -- Syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "romgrk/nvim-treesitter-context",
    },
    build = ":TSUpdate",
  },

  -- Explorer that adheres to Vim philosophy.
  "justinmk/vim-dirvish",
  -- Tree for undo history.
  "mbbill/undotree",
  -- Fancy start screen.
  "mhinz/vim-startify",

  -- Git plugins.
  "tpope/vim-fugitive",
  {
    "tpope/vim-rhubarb",
    -- Needed for opening git files on remote as I disable netrw.
    dependencies = { "tyru/open-browser.vim" },
  },
  { "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  "rhysd/conflict-marker.vim",
  -- Git commit browser.
  "junegunn/gv.vim",

  -- Lua-based fuzzy search.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- Zettelkasten plugin.
  { "oberblastmeister/neuron.nvim", branch = "unstable" },

  -- Copilot
  "github/copilot.vim",
}

local opts = {
  concurrency = 50,
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
      },
    },
  },
}

lazy.setup(plugins, opts)
