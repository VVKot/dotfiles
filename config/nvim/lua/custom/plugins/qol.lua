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
					require("snacks").words.jump(vim.v.count1)
				end,
				desc = "Next reference",
				mode = { "n", "t" },
			},
			{
				"[w",
				function()
					require("snacks").words.jump(-vim.v.count1)
				end,
				desc = "Prev reference",
				mode = { "n", "t" },
			},
			{
				"<leader>sr",
				function()
					require("snacks").rename.rename_file()
				end,
				desc = "Rename file",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				height = 0.6,
				width = 100,
				options = {
					signcolumn = "no",
					number = false,
					relativenumber = false,
					cursorline = false,
					foldcolumn = "0",
				},
			},
			plugins = {
				options = {
					ruler = false,
					showcmd = false,
					laststatus = 0,
				},
			},
		},
		keys = {
			{
				"<Leader>zz",
				function()
					require("zen-mode").toggle()
				end,
				desc = "Toggle Zen mode",
				mode = { "n" },
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
