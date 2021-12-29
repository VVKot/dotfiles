local nnoremap = vim.keymap.nnoremap
nnoremap({
  "<Leader>tu",
  function()
    vim.api.nvim_command([[UndotreeToggle]])
  end,
})
