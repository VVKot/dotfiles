vim.keymap.set("n", "<Leader>tu", function()
  vim.api.nvim_command([[UndotreeToggle]])
end)
