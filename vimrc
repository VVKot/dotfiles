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

" Fuzzy search for everything.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Sensible defaults.
Plug 'tpope/vim-sensible'
" Git plugin.
Plug 'tpope/vim-fugitive'
" Comments.
Plug 'tpope/vim-commentary'
" Add/remove/change surroundings.
Plug 'tpope/vim-surround'
" Useful pair-wise mappings.
Plug 'tpope/vim-unimpaired'
" Repeat plugin commands.
Plug 'tpope/vim-repeat'
" Autodetect indentation.
Plug 'tpope/vim-sleuth'
" Simplifies working with variants of the word.
Plug 'tpope/vim-abolish'

" Status line.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Zen mode.
Plug 'junegunn/goyo.vim'

call plug#end()

" EDITOR-WIDE SETTINGS.

" 256 colors + light background + true color support.
set t_Co=256
set background=light
if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux' )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Hard wrap at 120.
set textwidth=120

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
set ignorecase smartcase

" Automatically copy indentation from the previous line with an extra level.
set smartindent

" Instead of failing on unsaved changes provide a dialog.
set confirm

" Only redraw when needed.
set lazyredraw

" Highlight matching parenthesis.
set showmatch

" Split below and to the right by default.
set splitbelow
set splitright

" Don't use backups and swapfiles.
set nobackup
set nowritebackup
set noswapfile

" Don't show mode - there is a statusline for that.
set noshowmode

" Make Y behave like other capitals.
nnoremap Y y$

" Use Q to execute current line in shell and replace it with the output.
noremap Q !!$SHELL<CR>

" Easier indenting in visual mode.
vmap < <gv
vmap > >gv

" Set correct backspace options.
set backspace=indent,eol,start
imap <C-h> <BS>

" PLUGIN SETTINGS.

" PLUGIN - preservim/nerdtree.
let g:NERDTreeWinSize=60

" PLUGIN - neoclide/coc.nvim.

" Define default extensions to install.
let g:coc_global_extensions = ["coc-java", "coc-tsserver", "coc-json", "coc-css", "coc-html", "coc-yaml", "coc-snippets", "coc-pairs", "coc-prettier", "coc-jest"]

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
" Send coc#on_enter() to use improved bracket spacing.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd :<C-u>call CocActionAsync('jumpDefinition')<CR>
nmap <silent> gi :<C-u>call CocActionAsync('jumpImplementation')<CR>
nmap <silent> gr :<C-u>call CocActionAsync('jumpReferences')<CR>
nmap <silent> gy :<C-u>call CocActionAsync('jumpTypeDefinition')<CR>

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
" Applying codeAction to the selected region.
nmap <leader>as <Plug>(coc-codeaction-selected)
xmap <leader>as <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current line.
nmap <leader>aa  <Plug>(coc-codeaction)
" Symbol renaming.
nmap <leader>ar <Plug>(coc-rename)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>ca :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>ce :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>cc :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Yank history.
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<CR>

" CoC Plugin - coc-jest.
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

" PLUGIN - junegunn/fzf.vim.
set rtp+=/usr/local/opt/fzf
nnoremap <C-t> :Files<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>ff :RG<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fb :Buffers<CR>
" Use Rg in the preview mode.
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" PLUGIN - tpope/vim-fugitive.
nmap <Leader>gg :Git<CR>gg<c-n>
nnoremap <Leader>gd :Gvdiffsplit<CR>

" PLUGIN - preservim/nerdtree.
nnoremap <leader>tt :NERDTreeToggle<cr>
nnoremap <leader>tf :NERDTreeFind<cr>

" PLUGIN -  vim-airline/vim-airline.
let g:airline_section_b = ''
" PLUGIN -  vim-airline/vim-airline-themes.
let g:airline_theme='papercolor'

" PLUGIN - junegunn/goyo.
map <leader>z :Goyo 121 <bar> highlight StatusLineNC ctermfg=white <bar> highlight EndOfBuffer ctermfg=white <bar> set spell<CR>

