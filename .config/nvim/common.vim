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

" Set to auto read when a file is changed from the outside.
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime

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

" Make Y behave like other capitals.
nnoremap Y y$

" Use Q to execute macros.
noremap Q @q

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

" Do not show sign column.
set signcolumn=no

" Fold by markers.
set foldmethod=marker

" RG setup.
set grepprg=rg\ -S\ --vimgrep
set grepformat^=%f:%l:%c:%m

" Reload config shortcut.
nnoremap <leader>rr :source ~/.config/nvim/init.vim<CR>

" COLOR SETTINGS {{{1
set background=light

highlight SignColumn guibg=white ctermbg=white
highlight EndOfBuffer guifg=white ctermfg=white
highlight VertSplit guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLine guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLineNC guifg=white guibg=black ctermfg=white ctermbg=black
highlight Pmenu guifg=black guibg=white ctermfg=black ctermbg=white

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" STATUSLINE SETTINGS {{{1
set laststatus=2
set statusline=
set statusline+=%f
set statusline+=%r
set statusline+=%m
set statusline+=%=
set statusline+=%y
set statusline+=\ 
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=\ 
set statusline+=\|
set statusline+=\ 
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=\ 
set statusline+=:
set statusline+=%c

