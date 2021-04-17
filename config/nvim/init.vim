source ~/.config/nvim/common.vim

source ~/.config/nvim/settings.plugins.vim

if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif

" Show comments in italics.
highlight Comment cterm=italic gui=italic
" Built-in filter for quickfix/location lists
packadd cfilter
" More convenient log of changes to the current file
command! Glog Git log -p --follow -- %
command! GlogSummary Git log --follow -- %
