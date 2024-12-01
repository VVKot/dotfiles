if vim.g.vscode then
	return {}
end

return {
	-- Misc QoL improvements.
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = {
			{
				"]w",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next reference",
				mode = { "n", "t" },
			},
			{
				"[w",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev reference",
				mode = { "n", "t" },
			},
			{
				"<leader>sr",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename file",
			},
		},
	},
	-- Copilot
	"github/copilot.vim",
	-- Help with remembering mappings.
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},
	-- Explorer that adheres to Vim philosophy.
	"justinmk/vim-dirvish",
	-- Tree for undo history.
	"mbbill/undotree",
	-- Fancy start screen.
	{
		"mhinz/vim-startify",
		config = function()
			vim.keymap.set("n", "<Leader>ss", function()
				vim.api.nvim_command([[Startify]])
			end)
			vim.g.startify_session_persistence = 1
		end,
	},
	-- Icons.
	"nvim-tree/nvim-web-devicons",
	"ryanoasis/vim-devicons",
}
