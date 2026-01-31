local M = {}

M.setup = function()
	local treesitter = require("nvim-treesitter.config")

	treesitter.setup({
		auto_install = true,
		ignore_install = { "markdown", "markdown_inline" },
		highlight = { enable = true },
		indent = { enable = true },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
				},
			},
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<M-w>",
				node_incremental = "<M-w>",
				scope_incremental = "<M-e>",
				node_decremental = "<M-C-w>",
			},
		},
	})

	require("treesitter-context").setup({ enable = true })
	-- Visually distinguish tree-sitter context from regular text.
	vim.cmd([[hi TreesitterContext guibg=lightgrey]])
end

return M
