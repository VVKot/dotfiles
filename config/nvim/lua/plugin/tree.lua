local nnoremap = vim.keymap.nnoremap
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

nnoremap {
    "<Leader>tf", function() vim.api.nvim_command [[NvimTreeFindFile]] end
}

vim.g.nvim_tree_width = 60
vim.g.nvim_tree_bindings = {
    ["i"] = tree_cb("edit"),
    ["a"] = tree_cb("vsplit"),
    ["o"] = tree_cb("split"),
    ["p"] = tree_cb("preview")
}
