-- Basic QoL feature
require("mini.basics").setup({
  options = {
    extra_ui = true,
  },
  mappings = {
    basic = false,
    option_toggle_prefix = "",
  },
  autocommands = {
    basic = true,
    relnum_in_visual_mode = true,
  },
})

require("mini.move").setup()
require("mini.pairs").setup()

require("mini.completion").setup({
  window = {
    info = { border = "rounded" },
    signature = { border = "rounded" },
  },
})

require("mini.notify").setup()
