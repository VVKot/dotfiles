" More convenient log of changes to the current file
command! Glog Git log -p --follow -- %
command! GlogSummary Git log --follow -- %

" PLUGIN - tfnico/vim-gradle. {{{1

" Default to gradle if it is found at the root.
augroup check_for_gradlew
  autocmd!

  autocmd Filetype,BufEnter * if findfile('gradlew', system('git rev-parse --show-toplevel')[:-2]) == 'gradlew' | compiler! gradlew | endif
augroup END
