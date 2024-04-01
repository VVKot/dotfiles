local lazy = require("lazy")

local plugins = {
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
  -- Markdown.
  "tpope/vim-markdown",
  -- Exchange two motions.
  "tommcdo/vim-exchange",
  -- Minimal plugins for other things
  "echasnovski/mini.nvim",

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

  -- Testing.
  "tpope/vim-dispatch",
  "vim-test/vim-test",

  -- Lua-based fuzzy search.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

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
      local obsidian = require("obsidian")

      vim.keymap.set("n", "<C-]>", "<cmd>ObsidianFollowLink<CR>")
      vim.keymap.set("n", "<C-t>", "<C-o>")
      vim.keymap.set("n", "gzz", "<cmd>ObsidianSearch<CR>")
      vim.keymap.set("n", "gzb", "<cmd>ObsidianBacklinks<CR>")
      vim.keymap.set("n", "gzl", "<cmd>ObsidianLinks<CR>")
      vim.keymap.set("n", "gzo", "<cmd>ObsidianOpen<CR>")
      vim.keymap.set("n", "gzn", function()
        vim.cmd.ObsidianNew()
      end)
      vim.keymap.set("n", "gzt", function()
        vim.cmd.ObsidianTemplate({ args = { "template.md" } })
      end)

      vim.o.textwidth = 80
      vim.opt.spell = true

      obsidian.setup({
        open_app_foreground = true,

        completion = {
          nvim_cmp = false,
        },

        templates = {
          subdir = "templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
        },
        -- mimic ids from neuron
        note_id_func = function()
          local note_id = {}
          for i = 1, 8 do
            note_id[i] = string.format("%x", math.random(0, 0xf))
          end
          return table.concat(note_id)
        end,
        disable_frontmatter = true,
        log_level = vim.log.levels.WARN,

        mappings = {},
        workspaces = {
          {
            name = "no-vault",
            path = function()
              return assert(vim.fn.getcwd())
            end,
          },
        },
      })
    end,
  },

  "folke/zen-mode.nvim",
  "folke/twilight.nvim",
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
