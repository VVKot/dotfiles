if vim.g.vscode then
  return
end

return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("custom/telescope").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
