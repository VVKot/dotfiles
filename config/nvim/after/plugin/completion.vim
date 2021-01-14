" Support snippets for completion
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = "\<C-y>"

autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
