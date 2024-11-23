nmap <Leader>gg :tab Git<CR>gg)
nmap <Leader>gb :GBrowse<CR>
vmap <Leader>gb :GBrowse<CR>

" More convenient log of changes to the current file
command! Glog Git log -p --follow -- %
command! GlogSummary Git log --follow -- %
