local telescope = require("telescope")

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local themes = require("telescope.themes")
local insert_mappings = {
  ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
  ["<A-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
  ["<M-n>"] = actions.cycle_history_next,
  ["<M-p>"] = actions.cycle_history_prev,
  ["<M-t>"] = action_layout.toggle_preview,
}
local normal_mappings = {
  ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
  ["<A-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
  ["<M-n>"] = actions.cycle_history_next,
  ["<M-p>"] = actions.cycle_history_prev,
  ["<M-t>"] = action_layout.toggle_preview,
  ["<C-n>"] = actions.move_selection_next,
  ["<C-p>"] = actions.move_selection_previous,
  ["<C-c>"] = actions.close,
}

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top" },
    layout_strategy = "flex",
    scroll_strategy = "cycle",
    mappings = { i = insert_mappings, n = normal_mappings },
  },
  pickers = {
    builtin = { theme = "dropdown", previewer = false },
    buffers = { sort_mru = true, previewer = false },
    lsp_document_symbols = { theme = "dropdown", previewer = false },
    diagnostics = { theme = "dropdown", previewer = false },
    lsp_code_actions = { theme = "cursor" },
    lsp_range_code_actions = { theme = "cursor" },
  },
  extensions = {
    fzf = { override_generic_sorter = true, override_file_sorter = true },
    ["ui-select"] = {
      themes.get_cursor({}),
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<Leader><Leader>", function()
  builtin.git_files({})
end)
vim.keymap.set("n", "<Leader>tt", function()
  builtin.builtin({})
end)
vim.keymap.set("n", "<Leader>ff", function()
  builtin.live_grep({})
end)
vim.keymap.set("n", "<Leader>ft", function()
  builtin.grep_string({ search = vim.fn.input(":RG "), use_regex = true })
end)
vim.keymap.set("n", "<Leader>gs", function()
  builtin.git_status({})
end)
vim.keymap.set("n", "<Leader>fb", function()
  builtin.buffers({})
end)
