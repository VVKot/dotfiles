if vim.g.vscode then
	return {}
end

return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			local fzf_lua = require("fzf-lua")
			local actions = require("fzf-lua/actions")
			fzf_lua.setup({
				keymap = {
					builtin = {
						true,
						["<C-d>"] = "preview-page-down",
						["<C-u>"] = "preview-page-up",
					},
					fzf = {
						true,
						["ctrl-d"] = "preview-page-down",
						["ctrl-u"] = "preview-page-up",
					},
				},
				actions = {
					files = {
						true,
						["ctrl-q"] = actions.file_sel_to_qf,
						["alt-q"] = actions.file_sel_to_ll,
					},
				},
			})

			-- Customize default search command for obsidian.
			if not vim.g.obsidian then
				vim.keymap.set("n", "<Leader><Leader>", function()
					local is_inside_work_tree = {}
					local cwd = vim.fn.getcwd()
					if is_inside_work_tree[cwd] == nil then
						vim.fn.system("git rev-parse --is-inside-work-tree")
						is_inside_work_tree[cwd] = vim.v.shell_error == 0
					end

					if is_inside_work_tree[cwd] then
						fzf_lua.git_files()
					else
						fzf_lua.files()
					end
				end, {
					desc = "FZF git files/files",
				})
			end

			vim.keymap.set("n", "<Leader>fs", fzf_lua.grep, {
				desc = "FZF grep",
			})
			vim.keymap.set("n", "<Leader>ff", fzf_lua.live_grep, {
				desc = "FZF live grep",
			})
			vim.keymap.set("n", "<Leader>ft", fzf_lua.builtin, {
				desc = "FZF built-in",
			})
			vim.keymap.set("n", "<Leader>fb", fzf_lua.buffers, {
				desc = "FZF buffers",
			})
			vim.keymap.set("n", "<Leader>gs", fzf_lua.git_status, {
				desc = "FZF git status",
			})
			vim.keymap.set("n", "<Leader>gr", fzf_lua.lsp_references, {
				desc = "FZF LSP reference",
			})
			vim.keymap.set("n", "<Leader>lo", fzf_lua.lsp_document_symbols, {
				desc = "FZF LSP document symbols",
			})
			vim.keymap.set("n", "<Leader>ls", fzf_lua.lsp_live_workspace_symbols, {
				desc = "FZF LSP workspace symbols",
			})
		end,
	},
}
