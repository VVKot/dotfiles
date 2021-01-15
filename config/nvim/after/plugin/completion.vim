" Support snippets for completion
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = "\<C-y>"

augroup set_js_filetypes
  autocmd!

  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END
