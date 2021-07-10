set nocompatible
set secure
let mapleader = " "
let maplocalleader = " "

" Increase scrolloff.
set scrolloff=5

" Hard wrap at 120.
set textwidth=120

" Automatically paste from the system clipboard and copy to it.
set clipboard=unnamed

" No visual blink on error and no sound.
set visualbell t_vb=

" Enable mouse.
set mouse+=a

" Set to auto read when a file is changed from the outside.
augroup read_file_on_change
  autocmd!

  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
augroup END

" :W sudo saves the file.
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Relative line numbers + current line number.
set relativenumber
set number

" Set tab to 4 spaces that are automatically expanded/deleted.
set expandtab tabstop=4 softtabstop=4 shiftwidth=4

" Only make search case-sensetive if pattern has uppercase letters.
set ignorecase smartcase infercase

" Highlight and visualize substitute command.
set inccommand=nosplit

" Automatically copy indentation from the previous line with an extra level.
set smartindent

" Instead of failing on unsaved changes provide a dialog.
set confirm

" Only redraw when needed.
set lazyredraw

" Highlight matching parenthesis.
set showmatch

" Don't use backups and swapfiles.
set nobackup
set nowritebackup
set noswapfile

" Don't show mode - cursor indicates that.
set noshowmode

" Show excessive whitespace.
set list
set listchars=tab:»\ ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣

" Make Y behave like other capitals.
nnoremap Y y$

" Use Q to execute macros.
noremap Q @q

" Sane mapping to get out terminal mode.
tnoremap <C-o> <C-\><C-n>

" Easier indenting in visual mode.
vmap < <gv
vmap > >gv

" Set correct backspace options.
imap <C-h> <BS>

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
" Don't specify filename when opening file.
set shortmess+=c

" Split below and to the right by default.
set splitbelow
set splitright

" Show sign column.
set signcolumn=yes

" RG setup.
set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading
set grepformat^=%f:%l:%c:%m

" Reload config shortcut.
nnoremap <leader>rr :lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

augroup set_js_filetypes
  autocmd!

  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END

" Shortcuts for moving lines around
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Autofix last spelling mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Show comments in italics.
highlight Comment cterm=italic gui=italic guifg=blue ctermfg=blue

" Built-in filter for quickfix/location lists
packadd cfilter

" Highligh on yank
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

" Conceal level high enough to cover markdown
set conceallevel=2

" Use Perl-based regex by default
nnoremap / /\v
vnoremap / /\v

" Always apply substitutions globally
set gdefault

" Always move screen line-wise
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" COLOR SETTINGS {{{1
set background=light
set fillchars=eob:\ ,

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

highlight GitSignsAdd guifg=green guibg=white ctermfg=green ctermbg=white
highlight GitSignsChange guifg=blue guibg=white ctermfg=blue ctermbg=white
highlight GitSignsDelete guifg=red guibg=white ctermfg=red ctermbg=white

set termguicolors
