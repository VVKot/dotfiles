vim.g["test#strategy"] = "dispatch"

vim.keymap.set("n", "<Leader>tt", "<cmd>TestNearest<CR>")
vim.keymap.set("n", "<Leader>tf", "<cmd>TestFile<CR>")
vim.keymap.set("n", "<Leader>ts", "<cmd>TestSuite<CR>")
vim.keymap.set("n", "<Leader>tl", "<cmd>TestLast<CR>")
vim.keymap.set("n", "<Leader>tv", "<cmd>TestVisit<CR>")
