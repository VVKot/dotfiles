set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if exists('g:vscode')
  source ~/.mini.vimrc
else
  source ~/.vimrc
endif
