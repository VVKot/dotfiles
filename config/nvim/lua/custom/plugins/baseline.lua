return {
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
  -- Minimal QoL plugins.
  {
    "echasnovski/mini.nvim",
    config = function()
      require("custom/mini").setup()
    end,
  },
}
