local nnoremap = vim.keymap.nnoremap
nnoremap {
  "<Leader>ss",
  function()
    vim.api.nvim_command [[Startify]]
  end,
}
vim.g.startify_session_persistence = 1
