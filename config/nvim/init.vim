source ~/.config/nvim/common.vim

source ~/.config/nvim/settings.plugins.vim

if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif
