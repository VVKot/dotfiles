require("zen-mode").setup({
  window = {
    width = 121,
    height = 0.9,
    options = { signcolumn = "no", number = false, relativenumber = false },
  },
  plugins = {
    options = { enabled = true, showcmd = false },
    gitsigns = { enabled = true },
    tmux = { enabled = true },
  },
  on_open = function(win)
    vim.cmd([[SoftPencil]])
  end,
  on_close = function()
    vim.cmd([[PencilOff]])
  end,
})

local nnoremap = vim.keymap.nnoremap
nnoremap({
  "<Leader>zz",
  function()
    vim.api.nvim_command([[ZenMode]])
  end,
})
