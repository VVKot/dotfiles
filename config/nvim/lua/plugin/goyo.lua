local nnoremap = vim.keymap.nnoremap
nnoremap {"<Leader>zz", function() vim.api.nvim_command [[Goyo]] end}
vim.g.goyo_width = 121
