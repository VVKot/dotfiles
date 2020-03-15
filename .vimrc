" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim
" Disable compatibility mode.
set nocompatible
" Use UTF8.
set encoding=utf-8

" Do not use backups and undo files.
set nobackup
set undofile

" Global line numbers.
set nu
" Relative line numbers.
set rnu
" Highlight search.
set hls
" Incremental search.
set is
" Only make search case-sensetive if pattern has uppercase letters.
set smartcase
" Split below and to the right by default.
set splitbelow
set splitright
" Set filetype detection and indentation on.
filetype plugin indent on
" Enable syntax highlighting.
syntax on

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
