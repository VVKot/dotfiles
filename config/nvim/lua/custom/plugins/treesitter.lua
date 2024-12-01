return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("custom/treesitter").setup()
		end,
	},
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
}
