" PLUGIN - neoclide/coc.nvim. {{{1

" Make sure I don't OOM.
let g:coc_node_args = ['--max-old-space-size=8192']

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `<C-Space>` to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" Send coc#on_enter() to use improved bracket spacing.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navigate diagnostics.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Scroll popups.
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>ga <Plug>(coc-codeaction)
nmap <silent> <M-Enter> <Plug>(coc-codeaction)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Actions
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Symbol renaming.
nmap <leader>ar <Plug>(coc-rename)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)

autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" CoC PLUGIN - coc-jest. {{{2
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

" PLUGIN - junegunn/fzf.vim. {{{1
set rtp+=/usr/local/opt/fzf
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader><C-t> :Files<CR>
nnoremap <leader>ff :Rg 
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>f/ :History/<CR>

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

" PLUGIN - nvim-telescope/telescope.nvim. {{{1
nnoremap <Leader>lq :Telescope quickfix<CR>
nnoremap <Leader>ll :Telescope loclist<CR>
nnoremap <Leader>f<Leader> :Telescope current_buffer_fuzzy_find<CR>
nnoremap <Leader>fb :Telescope buffers<CR>
nnoremap <Leader>fm :Telescope marks<CR>
nnoremap <Leader>fw :Telescope grep_string<CR>
nnoremap <Leader>f: :Telescope command_history<CR>

" PLUGIN - antoinemadec/coc-fzf. {{{1
" Reset to defaults
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []

" Show all diagnostics.
nnoremap <silent> <leader>lg :<C-u>CocFzfList diagnostics<cr>
" Show all actions.
nnoremap <silent> <leader>la :<C-u>CocFzfList actions<cr>
" Show commands.
nnoremap <silent> <leader>lc :<C-u>CocFzfList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>lo  :<C-u>CocFzfList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>ls  :<C-u>CocFzfList symbols<cr>

" PLUGIN - justinmk/vim-dirvish. {{{1

" Show directories on top.
let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'

" Hijack netrw.
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore vsplit | silent Dirvish <args>

" PLUGIN - kyazdani42/nvim-tree.lua {{{1
nnoremap <Leader>tt :LuaTreeToggle<CR>
nnoremap <Leader>tf :LuaTreeFindFile<CR>

" PLUGIN - mbbill/undotree {{{1
nnoremap <Leader>tu :UndotreeToggle<CR>

" PLUGIN - tpope/vim-fugitive. {{{1
nmap <Leader>gg :tab Git<CR>gg<c-n>
nnoremap <Leader>gs :Gvdiffsplit<CR>

" PLUGIN - junegunn/goyo. {{{1
nnoremap <leader>zz :Goyo<CR>

let g:goyo_width=121

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

" PLUGIN - editorconfig/editorconfig-vim. {{{1
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" PLUGIN - tfnico/vim-gradle. {{{1

" Default to gradle if it is found at the root.
augroup CheckForGradlew
  autocmd!
  autocmd Filetype,BufEnter * if findfile('gradlew', system('git rev-parse --show-toplevel')[:-2]) == 'gradlew' | compiler! gradlew | endif
augroup END

" PLUGIN - fatih/vim-go. {{{1
let g:go_gopls_enabled=0
let g:go_def_mapping_enabled=0

" PLUGIN - npxbr/glow.nvim. {{{1
nnoremap <Leader>zm :Glow<CR>

" PLUGIN - mhinz/vim-startify. {{{1
let g:startify_session_persistence = 1
nnoremap <Leader>ss :Startify<CR>
