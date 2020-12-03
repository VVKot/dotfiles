let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'

" Hijack netrw.
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore vsplit | silent Dirvish <args>

" Add icons.
augroup dirvish_config
  au!

  autocmd FileType dirvish 
        \ call dirvish#add_icon_fn(
          \ { p ->  WebDevIconsGetFileTypeSymbol(p, p[-1:] == '/' ? 1 : 0) }
          \ )
augroup END
