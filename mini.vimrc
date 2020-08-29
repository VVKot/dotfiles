set nocompatible
let mapleader = " "
let maplocalleader = " "

" INSTALL VIM PLUG.
set rtp +=~/.vim

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" INSTALL PLUGINS.
call plug#begin('~/.vim/plugged')

" Sensible defaults.
Plug 'tpope/vim-sensible'
" Comments.
Plug 'tpope/vim-commentary'
" Add/remove/change surroundings.
Plug 'tpope/vim-surround'
" Useful pair-wise mappings.
Plug 'tpope/vim-unimpaired'
" Repeat plugin commands.
Plug 'tpope/vim-repeat'
" Simplifies working with variants of the word.
Plug 'tpope/vim-abolish'
" Handful shortcuts for *nix commands.
Plug 'tpope/vim-eunuch'

call plug#end()

" EDITOR-WIDE SETTINGS.

" 256 colors + light background + true color support.
set background=light

highlight SignColumn guibg=white ctermbg=white
highlight EndOfBuffer guifg=white ctermfg=white
highlight VertSplit guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLine guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLineNC guifg=white guibg=black ctermfg=white ctermbg=black
highlight Pmenu guifg=black guibg=white ctermfg=black ctermbg=white

set t_Co=256
if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux' )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Hard wrap at 120.
set textwidth=120

" Increase the context on the top/bottom.
set scrolloff=5

" Automatically paste from the system clipboard and copy to it.
set clipboard=unnamed

" Don't way for command after Esc.
set ttimeoutlen=0

" No visual blink on error and no sound.
set visualbell t_vb=
set belloff=all

" Set to auto read when a file is changed from the outside.
set autoread

" :W sudo saves the file.
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Relative line numbers + current line number.
set relativenumber
set number

" Set tab to 4 spaces that are automatically expanded/deleted.
set expandtab tabstop=4 softtabstop=4 shiftwidth=4

" Highlight search results.
set hlsearch

" Only make search case-sensetive if pattern has uppercase letters.
set ignorecase smartcase infercase

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

" Don't show mode - there is a statusline for that.
set noshowmode

" Make Y behave like other capitals.
nnoremap Y y$

" Use Q to execute macros.
noremap Q !!$SHELL<CR>

" Easier indenting in visual mode.
vmap < <gv
vmap > >gv

" Set correct backspace options.
set backspace=indent,eol,start
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
set shortmess+=cF

" STATUSLINE SETTINGS.
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

" Split below and to the right by default.
set splitbelow
set splitright

" Do not show sign column.
set signcolumn=no

