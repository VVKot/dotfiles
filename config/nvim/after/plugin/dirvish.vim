let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'

" Hijack netrw.
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore vsplit | silent Dirvish <args>
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Add icons.
augroup dirvish_config
  autocmd!

  autocmd FileType dirvish 
        \ call dirvish#add_icon_fn(
          \ { p ->  WebDevIconsGetFileTypeSymbol(p, p[-1:] == '/' ? 1 : 0) }
          \ )
augroup END
