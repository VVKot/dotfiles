if require("vkot/first_load")() then
  return
end

-- Hijack netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_nogx = 1

vim.cmd([[source ~/.config/nvim/common.vim]])
vim.cmd([[
if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif
]])

require("vkot/plugin_config")
require("vkot/lsp")
