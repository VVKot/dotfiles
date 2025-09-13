if vim.g.vscode then
	return {}
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Allows extra capabilities provided by blink.cmp
			"saghen/blink.cmp",
			{
				-- Important - this should be a dependency of nvim-lspconfig or otherwise be loaded before it.
				-- Otherwise, custom settings are not guaranteed to be picked up.
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						"lazy.nvim",
						"luvit-meta/library",
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		config = function()
			if vim.g.obsidian then
				return
			end

			require("custom/lsp").setup()
		end,
	},
	{
		"fatih/vim-go",
		config = function()
			vim.g.go_gopls_enabled = 0
			vim.g.go_def_mapping_enabled = 0
			vim.g.go_doc_keywordprg_enabled = 0
		end,
	},
	{
		"dense-analysis/ale",
		config = function()
			vim.g.ale_use_neovim_diagnostics_api = 1
			vim.g.ale_fix_on_save = 1
			vim.g.ale_languagetool_executable = "languagetool-commandline"
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
				sign = {
					enabled = false,
				},
				virtual_text = {
					enabled = true,
				},
				code_lenses = true,
			})
		end,
	},
}
