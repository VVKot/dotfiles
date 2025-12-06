local M = {}

M.setup = function()
	vim.opt.listchars = { tab = "⇥ ", leadmultispace = "┊ ", trail = "␣", nbsp = "⍽" }

	vim.lsp.inlay_hint.enable()

	vim.lsp.config("*", {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	})

	-- Key maps. {{{2

	-- diagnostics

	vim.diagnostic.config({
		virtual_text = { current_line = true },
	})

	vim.keymap.set("n", "gK", function()
		local new_config = not vim.diagnostic.config().virtual_lines
		vim.diagnostic.config({ virtual_lines = new_config })
	end, { desc = "Toggle diagnostic virtual_lines" })

	vim.keymap.set("n", "<Leader>ld", vim.diagnostic.setloclist, {
		desc = "Diagnostics to locationlist",
	})
	vim.keymap.set("n", "<C-Space>", vim.diagnostic.open_float, {
		desc = "Diagnostics open float",
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf

			-- references
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
				desc = "LSP definition",
				buffer = buffer,
			})
			vim.keymap.set("n", "gri", vim.lsp.buf.implementation, {
				desc = "LSP implementation",
				buffer = buffer,
			})
			vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {
				desc = "LSP type definition",
				buffer = buffer,
			})
			vim.keymap.set("n", "grr", function()
				vim.lsp.buf.references({ includeDeclaration = false })
			end, {
				desc = "LSP references",
				buffer = buffer,
			})

			-- actions
			vim.keymap.set({ "n", "v" }, "<M-Enter>", vim.lsp.buf.code_action, {
				desc = "LSP code action",
				buffer = buffer,
			})
			vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, {
				desc = "LSP code action",
				buffer = buffer,
			})
			vim.keymap.set("n", "grn", vim.lsp.buf.rename, {
				desc = "LSP rename",
				buffer = buffer,
			})

			-- lists
			vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, {
				desc = "LSP document symbols",
				buffer = buffer,
			})
		end,
	})

	-- Servers. {{{2

	vim.lsp.enable({
		"gopls",
		"rust_analyzer",
		"lua_ls",
		"ruff",
		"basedpyright",
		"helm_ls",
		"clangd",
		"nil_ls",
		"texlab",
		"yamlls",
	})
end

return M
