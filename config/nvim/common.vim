set secure

set splitkeep=cursor
set noswapfile

" Increase scroloff to give more context.
set scrolloff=5

" Hard wrap at 120.
set textwidth=120

" Automatically paste from the system clipboard and copy to it.
set clipboard=unnamed

" No visual blink on error and no sound.
set visualbell t_vb=

" Set to auto read when a file is changed from the outside.
augroup read_file_on_change
  autocmd!

  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
augroup END

" :W sudo saves the file.
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Instead of failing on unsaved changes provide a dialog.
set confirm

" Only redraw when needed.
set lazyredraw

" Highlight matching parenthesis.
set showmatch

" Show excessive whitespace.
set list
set listchars=tab:»\ ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣

" Make Y behave like other capitals.
nnoremap Y y$

" Use Q to execute macros.
noremap Q @q

" Easier indenting in visual mode.
vmap < <gv
vmap > >gv

" Set correct backspace options.
imap <C-h> <BS>

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" RG setup.
set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading
set grepformat^=%f:%l:%c:%m

augroup set_js_filetypes
  autocmd!

  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END

" Autofix last spelling mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Show comments in italics.
highlight Comment cterm=italic gui=italic guifg=blue ctermfg=blue

" Built-in filter for quickfix/location lists
packadd cfilter

" use open-browser for opening links
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

augroup neovim_terminal
    autocmd!
    autocmd TermOpen * :setlocal nonumber norelativenumber signcolumn=no
augroup END

set thesaurus=~/.vim/thesaurus

set laststatus=3
set statusline=
set statusline+=\ %F
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=\ %l:%c/%L
set statusline+=\ [%{&fileencoding?&fileencoding:&encoding}]
set statusline+=\ %{get(b:,'gitsigns_head','')}

set winbar=%t

" better diff algorithm
set diffopt+=linematch:50

" COLOR SETTINGS {{{1
set background=light

highlight Title ctermfg=blue guifg=blue
highlight NonText guifg=gray ctermfg=gray
highlight Whitespace guifg=gray ctermfg=gray
highlight SignColumn guibg=white ctermbg=white
highlight VertSplit guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLine guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLineNC guifg=white guibg=black ctermfg=white ctermbg=black
highlight Pmenu guifg=black guibg=white ctermfg=black ctermbg=white
highlight TabLineFill guifg=white guibg=white ctermfg=white ctermbg=white
highlight TabLine guifg=black guibg=white ctermfg=black ctermbg=white
highlight WinSeparator guifg=black guibg=white ctermfg=black ctermbg=white

highlight GitSignsAdd guifg=green guibg=white ctermfg=green ctermbg=white
highlight GitSignsChange guifg=blue guibg=white ctermfg=blue ctermbg=white
highlight GitSignsDelete guifg=red guibg=white ctermfg=red ctermbg=white
