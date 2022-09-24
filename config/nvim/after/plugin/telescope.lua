local telescope = require("telescope")

local actions = require("telescope.actions")
local mappings = {
  ["j"] = false,
  ["k"] = false,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
  ["<A-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
  ["<M-n>"] = actions.cycle_history_next,
  ["<M-p>"] = actions.cycle_history_prev,
  ["<esc>"] = actions.close,
  ["<C-[>"] = actions.close,
  ["<C-w>"] = function()
    vim.cmd([[normal! bcw]])
  end,
}

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top" },
    prompt_prefix = "🔭",
    scroll_strategy = "cycle",
    mappings = { i = mappings, n = mappings },
    winblend = 10,
  },
  pickers = {
    buffers = { sort_mru = true, ignore_current_buffer = true },
    builtin = { include_extensions = true },
    git_files = { show_untracked = false },
    lsp_code_actions = { theme = "dropdown", layout_config = { width = 0.6 } },
    lsp_range_code_actions = {
      theme = "dropdown",
      layout_config = { width = 0.6 },
    },
    spell_suggest = { theme = "dropdown", layout_config = { width = 0.6 } },
  },
  extensions = {
    fzf = { override_generic_sorter = true, override_file_sorter = true },
  },
})

telescope.load_extension("ultisnips")
telescope.load_extension("fzf")
telescope.load_extension("git_worktree")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<Leader><C-t>", function()
  builtin.git_files({})
end)
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
vim.keymap.set("n", "<Leader>gt", function()
  builtin.git_status({})
end)
vim.keymap.set("n", "<Leader>lq", function()
  builtin.quickfix({})
end)
vim.keymap.set("n", "<Leader>ll", function()
  builtin.loclist({})
end)
vim.keymap.set("n", "<Leader>f<Leader>", function()
  builtin.current_buffer_fuzzy_find({})
end)
vim.keymap.set("n", "<Leader>fb", function()
  builtin.buffers({})
end)
vim.keymap.set("n", "<Leader>fm", function()
  builtin.marks({})
end)
vim.keymap.set("n", "<Leader>f:", function()
  builtin.command_history({})
end)
vim.keymap.set("n", "<Leader>f/", function()
  builtin.search_history({})
end)
vim.keymap.set("n", "z=", function()
  builtin.spell_suggest({})
end)
