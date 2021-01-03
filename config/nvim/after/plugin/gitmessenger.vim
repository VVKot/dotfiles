function! s:setup_git_messenger() abort
  nmap <buffer><C-o> o
  nmap <buffer><C-i> O
endfunction

augroup CustomGitMessenger
  au!
  autocmd FileType gitmessengerpopup call <SID>setup_git_messenger()
augroup END
