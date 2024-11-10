local lazy = require("lazy")

local plugins = {
  -- Sensible defaults.
  "tpope/vim-sensible",
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
  -- Markdown.
  "tpope/vim-markdown",
  -- Exchange two motions.
  "tommcdo/vim-exchange",
  -- Minimal plugins for other things
  "echasnovski/mini.nvim",
  -- Another collection of minimal plugins
  "folke/snacks.nvim",

  -- Neovim LSP.
  "neovim/nvim-lspconfig",
  -- Additional lua configuration for plugin interactions
  "folke/neodev.nvim",
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
  },

  -- Explorer that adheres to Vim philosophy.
  "justinmk/vim-dirvish",
  -- Tree for undo history.
  "mbbill/undotree",
  -- Fancy start screen.
  "mhinz/vim-startify",

  -- Git plugins.
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  { "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  "rhysd/conflict-marker.vim",
  -- Git commit browser.
  "junegunn/gv.vim",

  -- Testing.
  "tpope/vim-dispatch",
  "vim-test/vim-test",

  -- Lua-based fuzzy search.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Zettelkasten plugin.
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- use latest release instead of latest commit
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cond = function()
      return vim.fn.isdirectory(".obsidian") ~= 0
    end,
    config = function()
      require("vkot/plugins/obsidian")
    end,
  },

  "folke/zen-mode.nvim",
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },
  "nvim-tree/nvim-web-devicons",
  "ryanoasis/vim-devicons",

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
