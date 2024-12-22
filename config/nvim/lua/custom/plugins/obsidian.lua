if vim.g.vscode then
	return {}
end

return {
	{
		"epwalsh/obsidian.nvim",
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
