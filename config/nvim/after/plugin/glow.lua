local nnoremap = vim.keymap.nnoremap
nnoremap {
  "<Leader>zm",
  function()
    vim.api.nvim_command [[Glow]]
  end,
}
