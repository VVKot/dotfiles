source ~/.config/nvim/common.vim

source ~/.config/nvim/install.vimplug.vim

call plug#begin()
source ~/.config/nvim/basic.plugins.vim
source ~/.config/nvim/advanced.plugins.vim
call plug#end()

source ~/.config/nvim/settings.plugins.vim

if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif

lua require 'init'
