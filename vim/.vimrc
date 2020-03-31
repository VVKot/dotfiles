let mapleader = " "
let maplocalleader = " "

" INSTALL VIM PLUG.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" INSTALL PLUGINS.
call plug#begin('~/.vim/plugged')
" Autocompletion engine utilizing LSP from VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tree plugin.
Plug 'preservim/nerdtree'

" Git plugin.
Plug 'tpope/vim-fugitive'

" Fuzzy search for everything.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Comments.
Plug 'tpope/vim-commentary'

" Add/remove/change surroundings.
Plug 'tpope/vim-surround'

" Repeat plugin commands.
Plug 'tpope/vim-repeat'
call plug#end()

" EDITOR-WIDE SETTINGS.

" Scroll the buffer to align to create space around cursor position.
set scrolloff=5
set sidescrolloff=5

" Use UTF8.
set encoding=utf-8

" Sets how many lines of history VIM has to remember.
set history=500

" Hard wrap at 120.
set textwidth=120

" Automatically paste from the system clipboard and copy to it.
set clipboard=unnamed

" No visual blink on error.
set visualbell t_vb=

" Set to auto read when a file is changed from the outside.
set autoread
au FocusGained,BufEnter * checktime

" Fast saving and quitting.
nnoremap <leader>w :update<cr>
nnoremap <leader>q :q<cr>

" :W sudo saves the file.
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Relative line numbers.
set rnu

" Highlight search.
set hls
" Incremental search.
set is
" Only make search case-sensetive if pattern has uppercase letters.
set ignorecase smartcase

" Make backspace behave like it does in other editors.
set backspace=indent,eol,start

" Split below and to the right by default.
set splitbelow
set splitright

" Don't use backups and swapfiles.
set nobackup
set nowritebackup
set noswapfile

" Set filetype detection and indentation on.
filetype plugin indent on
" Enable syntax highlighting.
syntax on

" Movement in insert mode.
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k

" Move between buffers using Tab.
nnoremap <tab>   <c-w>w
nnoremap <s-tab> <c-w>W

" Make Y behave like other capitals.
nnoremap Y y$

" Use qq to record, Q to replay.
nnoremap Q @q

" PLUGIN SETTINGS.

" PLUGIN - neoclide/coc.nvim.

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" PLUGIN - junegunn/fzf.vim.
set rtp+=/usr/local/opt/fzf
nnoremap <C-t> :Files<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>ff :Rg<CR>
nnoremap <leader>fc :Commands<CR>

" PLUGIN - tpope/vim-fugitive.
nmap <Leader>g :Git<CR>gg<c-n>
nnoremap <Leader>d :Gvdiffsplit<CR>

" PLUGIN - preservim/nerdtree.
nnoremap <leader>tt :NERDTreeToggle<cr>
nnoremap <leader>tf :NERDTreeFind<cr>
