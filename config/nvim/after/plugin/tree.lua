local nnoremap = vim.keymap.nnoremap
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

nnoremap {
    "<Leader>tf", function() vim.api.nvim_command [[NvimTreeFindFile]] end
}

vim.g.nvim_tree_width = 60
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_bindings = {
    {key = "i", cb = tree_cb("edit")}, {key = "a", cb = tree_cb("vsplit")},
    {key = "o", cb = tree_cb("split")}, {key = "p", cb = tree_cb("preview")}
}
