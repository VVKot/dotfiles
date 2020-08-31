" PLUGIN - preservim/nerdtree. {{{1
nnoremap <leader>tt :NERDTreeToggle<cr>
nnoremap <leader>tf :NERDTreeFind<cr>
let g:NERDTreeWinSize=60
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1

" PLUGIN - neoclide/coc.nvim. {{{1

" Make sure I don't OOM.
let g:coc_node_args = ['--max-old-space-size=8192']

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

" Map function and class text objects.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

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
nnoremap <C-t> :Files<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>ff :Rg 
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>f: :History:<CR>
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

" PLUGIN - antoinemadec/coc-fzf. {{{1
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

" PLUGIN - justinmk/vim-dirvish. {{{1

" Show directories on top
let g:dirvish_mode = ':sort ,^.*[\/],'

" PLUGIN - tpope/vim-fugitive. {{{1
nmap <Leader>gg :vertical Git<CR>gg<c-n>
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

" PLUGIN - editorconfig/editorconfig-vim. {{{1
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" PLUGIN - tfnico/vim-gradle. {{{1
autocmd FileType * compiler gradlew

" PLUGIN - fatih/vim-go. {{{1
let g:go_gopls_enabled=0
