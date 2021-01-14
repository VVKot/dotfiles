function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  setlocal spell

  highlight Title ctermfg=blue guifg=blue
  highlight NonText guifg=gray ctermfg=gray
  highlight Whitespace guifg=gray ctermfg=gray
  highlight StatusLine guifg=white guibg=white ctermfg=white ctermbg=white
  highlight StatusLineNC guifg=white guibg=white ctermfg=white ctermbg=white
  highlight VertSplit guifg=white guibg=white ctermfg=white ctermbg=white
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  setlocal nospell

  set background=light

  highlight Title ctermfg=blue guifg=blue
  highlight NonText guifg=gray ctermfg=gray
  highlight Whitespace guifg=gray ctermfg=gray
  highlight SignColumn guibg=white ctermbg=white
  highlight EndOfBuffer guifg=white ctermfg=white
  highlight VertSplit guifg=white guibg=black ctermfg=white ctermbg=black
  highlight StatusLine guifg=white guibg=black ctermfg=white ctermbg=black
  highlight StatusLineNC guifg=white guibg=black ctermfg=white ctermbg=black
  highlight Pmenu guifg=black guibg=white ctermfg=black ctermbg=white
  highlight TabLineFill guifg=white guibg=white ctermfg=white ctermbg=white
  highlight TabLine guifg=black guibg=white ctermfg=black ctermbg=white
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" PLUGIN - tfnico/vim-gradle. {{{1

" Default to gradle if it is found at the root.
augroup CheckForGradlew
  autocmd!
  autocmd Filetype,BufEnter * if findfile('gradlew', system('git rev-parse --show-toplevel')[:-2]) == 'gradlew' | compiler! gradlew | endif
augroup END
