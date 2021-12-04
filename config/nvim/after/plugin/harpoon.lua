require("harpoon").setup()

local harpoon_term = require "harpoon.term"
local nnoremap = vim.keymap.nnoremap
nnoremap {
  "<Leader>t1",
  function()
    harpoon_term.gotoTerminal(1)
  end,
}
nnoremap {
  "<Leader>t2",
  function()
    harpoon_term.gotoTerminal(2)
  end,
}
nnoremap {
  "<Leader>t3",
  function()
    harpoon_term.gotoTerminal(3)
  end,
}
nnoremap {
  "<Leader>t4",
  function()
    harpoon_term.gotoTerminal(4)
  end,
}
