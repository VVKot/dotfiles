if vim.g.vscode then
  return
end

return {
  -- Copilot
  "github/copilot.vim",
  -- Help with remembering mappings.
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },
  -- Explorer that adheres to Vim philosophy.
  "justinmk/vim-dirvish",
  -- Tree for undo history.
  "mbbill/undotree",
  -- Fancy start screen.
  {
    "mhinz/vim-startify",
    config = function()
      vim.keymap.set("n", "<Leader>ss", function()
        vim.api.nvim_command([[Startify]])
      end)
      vim.g.startify_session_persistence = 1
    end,
  },
  -- Icons.
  "nvim-tree/nvim-web-devicons",
  "ryanoasis/vim-devicons",
}
