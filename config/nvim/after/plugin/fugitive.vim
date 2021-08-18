nmap <Leader>gg :tab Git<CR>gg)
nmap <Leader>gb :GBrowse<CR>
vmap <Leader>gb :GBrowse<CR>
nnoremap <Leader>gs :vert Gdiffsplit!<CR>

" Native support for Dispatch was dropped from Fugitive
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>
