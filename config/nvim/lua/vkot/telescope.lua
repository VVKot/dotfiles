local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_sorters = require("telescope.sorters")
local telescope_mappings = {
  ["j"] = false,
  ["k"] = false,
  ["<C-j>"] = telescope_actions.move_selection_next,
  ["<C-k>"] = telescope_actions.move_selection_previous,
  ["<esc>"] = telescope_actions.close,
}

telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_position = "top",
    prompt_prefix = "🔭",
    scroll_strategy = "cycle",
    mappings = {
      i = telescope_mappings,
      n = telescope_mappings,
    },
    file_sorter = telescope_sorters.get_fzy_sorter,
    generic_sorter = telescope_sorters.get_fzy_sorter,
    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  }
}

