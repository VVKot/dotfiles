local nnoremap = vim.keymap.nnoremap
local tree_cb = require("nvim-tree.config").nvim_tree_callback

local bindings = {
  { mode = "n", key = "i", cb = tree_cb "edit" },
  { mode = "n", key = "a", cb = tree_cb "vsplit" },
  { mode = "n", key = "o", cb = tree_cb "split" },
  { mode = "n", key = "p", cb = tree_cb "preview" },
}
require("nvim-tree").setup {
  update_to_buf_dir = { enable = false, auto_open = false },
  view = {
    width = 60,
    side = "left",
    mappings = { custom_only = true, list = bindings },
  },
}

nnoremap {
  "<Leader>tf",
  function()
    vim.api.nvim_command [[NvimTreeFindFile]]
  end,
}

vim.g.nvim_tree_disable_window_picker = 1
