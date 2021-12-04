local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  ensure_installed = "all",
  ignore_install = { "haskell" },
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  context_commentstring = { enable = true, enable_autocmd = false },
  autopairs = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-w>",
      node_incremental = "<M-w>",
      scope_incremental = "<M-e>",
      node_decremental = "<M-C-w>",
    },
  },
}

-- Disable context by default.
require("treesitter-context").setup { enable = false }
-- Visually distinguish tree-sitter context from regular text.
vim.cmd [[hi TreesitterContext guibg=lightgrey]]
