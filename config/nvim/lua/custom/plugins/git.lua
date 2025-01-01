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
			end, {
				desc = "conflict - accept none",
			})
			vim.keymap.set("n", "<Leader>h2", function()
				vim.api.nvim_command([[ConflictMarkerOurselves]])
			end, {
				desc = "conflict - accept ours",
			})
			vim.keymap.set("n", "<Leader>h3", function()
				vim.api.nvim_command([[ConflictMarkerThemselves]])
			end, {
				desc = "conflict - accept theirs",
			})
			vim.keymap.set("n", "<Leader>h4", function()
				vim.api.nvim_command([[ConflictMarkerBoth]])
			end, {
				desc = "conflict - accept both",
			})
			vim.keymap.set("n", "<Leader>h4", function()
				vim.api.nvim_command([[ConflictMarkerBoth!]])
			end, {
				desc = "conflict - accept both (reverse)",
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				attach_to_untracked = true,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, {
						desc = "GitSigns next hunk",
					})

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, {
						desc = "GitSigns prev hunk",
					})

					-- Actions
					map("n", "<Leader>hs", gitsigns.stage_hunk, {
						desc = "GitSigns stage hunk",
					})
					map("n", "<Leader>hr", gitsigns.reset_hunk, {
						desc = "GitSigns reset hunk",
					})
					map("v", "<Leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, {
						desc = "GitSigns stage hunk",
					})
					map("v", "<Leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, {
						desc = "GitSigns reset hunk",
					})
					map("n", "<Leader>hS", gitsigns.stage_buffer, {
						desc = "GitSigns stage buffer",
					})
					map("n", "<Leader>hu", gitsigns.undo_stage_hunk, {
						desc = "GitSigns undo hunk",
					})
					map("n", "<Leader>hR", gitsigns.reset_buffer, {
						desc = "GitSigns reset buffer",
					})
					map("n", "<Leader>hp", gitsigns.preview_hunk, {
						desc = "GitSigns preview hunk",
					})
					map("n", "<Leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, {
						desc = "GitSigns blame line",
					})

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
}
