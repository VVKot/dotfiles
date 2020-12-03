source ~/.config/nvim/common.vim

source ~/.config/nvim/install.vimplug.vim

call plug#begin()
source ~/.config/nvim/basic.plugins.vim
call plug#end()

" Show comments in italics.
highlight Comment cterm=italic gui=italic
