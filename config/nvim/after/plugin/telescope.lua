local telescope = require("telescope")

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
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
    path_display = {
      "filename_first",
    },
  },
  pickers = {
    builtin = { previewer = false },
    buffers = { sort_mru = true, previewer = false },
    lsp_document_symbols = { previewer = false },
    diagnostics = { previewer = false, path_display = "hidden" },
    git_files = { previewer = true },
    find_files = { previewer = true },
  },
  extensions = {
    fzf = { override_generic_sorter = true, override_file_sorter = true },
  },
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<Leader><Leader>", function()
  local is_inside_work_tree = {}
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files({})
  else
    builtin.find_files({})
  end
end)
vim.keymap.set("n", "<Leader>ft", function()
  builtin.builtin({})
end)
vim.keymap.set("n", "<Leader>ff", function()
  builtin.live_grep({})
end)
vim.keymap.set("n", "<Leader>fs", function()
  builtin.grep_string({ search = vim.fn.input(":RG "), use_regex = true })
end)
vim.keymap.set("n", "<Leader>gs", function()
  builtin.git_status({})
end)
vim.keymap.set("n", "<Leader>fb", function()
  builtin.buffers({})
end)
