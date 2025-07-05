if vim.g.vscode then
	return {}
end

return {
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					code_actions = {
						ui_select_fallback = true,
					},
				},
				server = {
					on_attach = function()
						local buffer = vim.api.nvim_get_current_buf()
						vim.keymap.set("n", "<M-Enter>", function()
							vim.cmd.RustLsp("codeAction")
						end, { silent = true, desc = "LSP code action", buffer = buffer })
						vim.keymap.set("n", "gra", function()
							vim.cmd.RustLsp("codeAction")
						end, { silent = true, desc = "LSP code action", buffer = buffer })
						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { silent = true, desc = "Rust hover", buffer = buffer })
						vim.keymap.set("n", "grh", "<Plug>RustHoverAction", {
							desc = "Rust hover action",
							buffer = buffer,
						})
					end,
					default_settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								allFeatures = true,
								command = "clippy",
							},
							cargo = {
								allFeatures = true,
							},
						},
					},
				},
				dap = {
					adapter = {
						type = "executable",
						command = vim.fn.exepath("lldb-dap"),
						name = "lldb",
					},
				},
			}
		end,
	},
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
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
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
	{
		"someone-stole-my-name/yaml-companion.nvim",
		config = function()
			require("telescope").load_extension("yaml_schema")
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
}
