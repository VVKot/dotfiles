" Integrate with tag navigation
set tagfunc=CocTagFunc

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
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-implementation)
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

augroup custom_coc_config
  autocmd!

  " Setup format expression
  autocmd FileType typescript,typescriptreact,typescript.tsx,javascript,javascriptreact,javascript.jsx,css,scss,sass,less setl formatexpr=CocAction('formatSelected')
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
" Perform refactorings from visual mode
xmap <leader>a  <Plug>(coc-codeaction-selected)

" PLUGIN - antoinemadec/coc-fzf.

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
