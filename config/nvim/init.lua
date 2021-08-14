if require "first_load"() then
  return
end

vim.cmd [[source ~/.config/nvim/common.vim]]

vim.cmd [[source ~/.config/nvim/settings.plugins.vim]]

vim.cmd [[
if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif
]]

require "plugin_config"
