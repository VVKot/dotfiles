if vim.g.vscode then
	return {}
end

return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"junegunn/gv.vim",
	{
		"rhysd/conflict-marker.vim",
		config = function()
			vim.g.conflict_marker_enable_mappings = 0
			vim.keymap.set("n", "<Leader>h1", function()
				vim.api.nvim_command([[ConflictMarkerNone]])
			end)
			vim.keymap.set("n", "<Leader>h2", function()
				vim.api.nvim_command([[ConflictMarkerOurselves]])
			end)
			vim.keymap.set("n", "<Leader>h3", function()
				vim.api.nvim_command([[ConflictMarkerThemselves]])
			end)
			vim.keymap.set("n", "<Leader>h4", function()
				vim.api.nvim_command([[ConflictMarkerBoth]])
			end)
			vim.keymap.set("n", "<Leader>h4", function()
				vim.api.nvim_command([[ConflictMarkerBoth!]])
			end)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local opts = { buffer = bufnr }

					-- Navigation
					vim.keymap.set("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					vim.keymap.set("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
					vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
					vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts)
					vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)
					vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts)
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk_inline, opts)
					vim.keymap.set("n", "<leader>hd", gs.toggle_deleted, opts)

					-- Text object
					vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
				end,
			})
		end,
	},
}
