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

-- Moving visual selection
require("mini.move").setup()
