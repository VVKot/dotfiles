set nocompatible
let mapleader = " "
let maplocalleader = " "

" INSTALL VIM PLUG. {{{1
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" INSTALL PLUGINS. {{{1
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

" Autocompletion engine utilizing LSP from VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Additional syntax support
Plug 'sheerun/vim-polyglot'

" Tree plugin.
Plug 'preservim/nerdtree'
" Alternative explorer plugin
Plug 'justinmk/vim-dirvish'

" Fuzzy search for everything.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

" Git plugin.
Plug 'tpope/vim-fugitive'

" Autodetect indentation.
Plug 'tpope/vim-sleuth'

" More convenient make.
Plug 'tpope/vim-dispatch'

" Editor config support.
Plug 'editorconfig/editorconfig-vim'

" Gradle compiler support.
Plug 'tfnico/vim-gradle'

" Zen mode.
Plug 'junegunn/goyo.vim'

call plug#end()

" EDITOR-WIDE SETTINGS. {{{1

" 256 colors + light background + true color support.
set background=light

highlight SignColumn guibg=white ctermbg=white
highlight EndOfBuffer guifg=white ctermfg=white
highlight VertSplit guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLine guifg=white guibg=black ctermfg=white ctermbg=black
highlight StatusLineNC guifg=white guibg=black ctermfg=white ctermbg=black
highlight Pmenu guifg=black guibg=white ctermfg=black ctermbg=white

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
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime

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
noremap Q @q

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

" Split below and to the right by default.
set splitbelow
set splitright

" Do not show sign column.
set signcolumn=no

" Fold by markers
set foldmethod=marker

" STATUSLINE SETTINGS. {{{2
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

" PLUGIN SETTINGS. {{{1

" PLUGIN - preservim/nerdtree. {{{2
nnoremap <leader>tt :NERDTreeToggle<cr>
nnoremap <leader>tf :NERDTreeFind<cr>
let g:NERDTreeWinSize=60
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1

" PLUGIN - neoclide/coc.nvim. {{{2

" Define default extensions to install.
let g:coc_global_extensions = [
  \ "coc-java", 
  \ "coc-tsserver", 
  \ "coc-json", 
  \ "coc-css", 
  \ "coc-html", 
  \ "coc-yaml", 
  \ "coc-pairs", 
  \ "coc-eslint",
  \ "coc-tslint-plugin",
  \ "coc-stylelint",
  \ "coc-jest",
  \ "coc-react-refactor"
  \ ]

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

" Use `<C-a>` to trigger completion.
inoremap <silent><expr> <C-a> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" Send coc#on_enter() to use improved bracket spacing.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navigate diagnostics.
nmap <silent> <leader>gE <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ge <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>gd :<C-u>call CocActionAsync('jumpDefinition')<CR>
nmap <silent> <leader>gi :<C-u>call CocActionAsync('jumpImplementation')<CR>
nmap <silent> <leader>gr :<C-u>call CocActionAsync('jumpReferences')<CR>
nmap <silent> <leader>gy :<C-u>call CocActionAsync('jumpTypeDefinition')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Actions
if has('nvim')
    function! s:cocActionsOpenFromSelected(type) abort
      execute 'CocCommand actions.open ' . a:type
    endfunction
    xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
else
    nmap <leader>as <Plug>(coc-codeaction-selected)
    xmap <leader>as <Plug>(coc-codeaction-selected)
    nmap <leader>aa  <Plug>(coc-codeaction)
endif
" Symbol renaming.
nmap <leader>ar <Plug>(coc-rename)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)

autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" CoC PLUGIN - coc-jest. {{{3
" Init jest in current cwd, require global jest command exists.
command! JestInit :call CocActionAsync('runCommand', 'jest.init')
" Run jest for current project.
command! -nargs=0 Jest :call  CocActionAsync('runCommand', 'jest.projectTest')
" Run jest for current file.
command! -nargs=0 JestCurrentFile :call  CocActionAsync('runCommand', 'jest.fileTest', ['%'])
nnoremap <leader>jj :JestCurrentFile<CR>
" Run jest for current test.
command! -nargs=0 JestCurrentTest :call  CocActionAsync('runCommand', 'jest.singleTest')
nnoremap <leader>jt :JestCurrentTest<CR>

" PLUGIN - junegunn/fzf.vim. {{{2
set rtp+=/usr/local/opt/fzf
nnoremap <C-t> :Files<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>ff :Rg 
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fb :Buffers<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" PLUGIN - antoinemadec/coc-fzf. {{{2
" Reset to defaults
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []

" Show all diagnostics.
nnoremap <silent> <leader>ca :<C-u>CocFzfList diagnostics<cr>
" Show commands.
nnoremap <silent> <leader>cc :<C-u>CocFzfList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>co  :<C-u>CocFzfList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>cs  :<C-u>CocFzfList symbols<cr>

" PLUGIN - justinmk/vim-dirvish. {{{2
let g:dirvish_mode = ':sort ,^.*[\/],'

" PLUGIN - tpope/vim-fugitive. {{{2
nmap <Leader>gg :vertical Git<CR>gg<c-n>
nnoremap <Leader>gs :Gvdiffsplit<CR>

" PLUGIN - junegunn/goyo. {{{2
nnoremap <leader>zz :Goyo<CR>

let g:goyo_width=121

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  setlocal spell

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

  highlight SignColumn guibg=white ctermbg=white
  highlight EndOfBuffer guifg=white ctermfg=white
  highlight VertSplit guifg=white guibg=black ctermfg=white ctermbg=black
  highlight StatusLine guifg=white guibg=black ctermfg=white ctermbg=black
  highlight StatusLineNC guifg=white guibg=black ctermfg=white ctermbg=black
  highlight Pmenu guifg=black guibg=white ctermfg=black ctermbg=white
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" PLUGIN - editorconfig/editorconfig-vim. {{{2
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" PLUGIN - tfnico/vim-gradle. {{{2
autocmd FileType * compiler gradlew
