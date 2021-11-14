if require("vkot/first_load")() then return end

vim.cmd [[source ~/.config/nvim/common.vim]]

vim.cmd [[source ~/.config/nvim/settings.plugins.vim]]

vim.cmd [[
if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif
]]

require("impatient")
require("vkot/plugin_config")

-- Load astronauta first so that I can use mapping functions
vim.cmd [[runtime plugin/astronauta.vim]]
require("vkot/lsp")
