-- Set up leader to ensure correct mappings setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("vkot/ensure_lazy")

vim.cmd([[source ~/.config/nvim/common.vim]])
vim.cmd([[
if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif
]])

require("vkot/plugins")
-- Needs to happen before generic LSP setup
require('neodev').setup()
require("vkot/lsp")
