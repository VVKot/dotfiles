local M = {}

M.setup = function()
	local telescope = require("telescope")

	local actions = require("telescope.actions")
	local action_layout = require("telescope.actions.layout")
	local insert_mappings = {
		["<M-t>"] = action_layout.toggle_preview,
	}
	local normal_mappings = {
		["<M-t>"] = action_layout.toggle_preview,
		["<C-c>"] = actions.close,
	}

	telescope.setup({
		defaults = {
			sorting_strategy = "ascending",
			layout_config = { prompt_position = "top" },
			layout_strategy = "flex",
			scroll_strategy = "cycle",
			mappings = { i = insert_mappings, n = normal_mappings },
			wrap_results = true,
			path_display = {
				"filename_first",
			},
		},
		pickers = {
			buffers = { sort_mru = true },
			diagnostics = { path_display = "hidden" },
		},
	})
end

return M
