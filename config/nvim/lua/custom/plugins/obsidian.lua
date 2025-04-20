if vim.g.vscode then
	return {}
end

return {
	"preservim/vim-pencil",
	{
		"obsidian-nvim/obsidian.nvim",
		priority = 100,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cond = function()
			return vim.fn.isdirectory(".obsidian") ~= 0
		end,
		config = function()
			require("custom/obsidian").setup()
		end,
	},
}
