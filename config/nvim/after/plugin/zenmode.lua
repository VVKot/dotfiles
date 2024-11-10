vim.keymap.set("n", "<Leader>zz", "<cmd>ZenMode<CR>")

require("zen-mode").setup({
  window = {
    width = 100,
    height = 0.75,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      cursorline = false,
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,
      showcmd = false,
      laststatus = 0,
    },
    tmux = { enabled = true },
  },
})
