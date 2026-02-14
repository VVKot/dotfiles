vim.bo.omnifunc = "vim_dadbod_completion#omni"

-- mirror SSMS
vim.keymap.set("n", "<F5>", ":%DB<CR>", { buffer = true, silent = true, desc = "Execute SQL file" })
vim.keymap.set("v", "<F5>", ":DB<CR>", { buffer = true, silent = true, desc = "Execute SQL selection" })
vim.keymap.set("n", "<C-e>", ":%DB<CR>", { buffer = true, silent = true, desc = "Execute SQL file" })
vim.keymap.set("v", "<C-e>", ":DB<CR>", { buffer = true, silent = true, desc = "Execute SQL selection" })
