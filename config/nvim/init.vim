source ~/.config/nvim/common.vim

source ~/.config/nvim/settings.plugins.vim

if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif

" Show comments in italics.
highlight Comment cterm=italic gui=italic
