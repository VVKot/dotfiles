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

local statusline = require("mini.statusline")

statusline.setup({
  content = {
    active = function()
      local filename      = statusline.section_filename({ trunc_width = 140 })
      local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = statusline.section_lsp({ trunc_width = 75 })
      local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
      local location      = statusline.section_location({ trunc_width = 75 })

      return statusline.combine_groups({
        { hl = 'statuslineFilename', strings = { filename } },
        '%<', -- Mark general truncate point
        '%=', -- End left alignment
        { hl = 'statuslineDevinfo',  strings = { diagnostics, lsp } },
        { hl = 'statuslineFileinfo', strings = { fileinfo } },
        { hl = 'statuslineFileinfo', strings = { location } },
      })
    end
  },
  set_vim_settings = false,
})

