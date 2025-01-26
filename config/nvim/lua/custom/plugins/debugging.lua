if vim.g.vscode then
	return {}
end

return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP continue",
				mode = { "n" },
			},
			{
				"<Leader>dd",
				function()
					require("dap").continue()
				end,
				desc = "DAP continue",
				mode = { "n" },
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP step over",
				mode = { "n" },
			},
			{
				"<Leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "DAP step over",
				mode = { "n" },
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP step into",
				mode = { "n" },
			},
			{
				"<Leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "DAP step into",
				mode = { "n" },
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP step out",
				mode = { "n" },
			},
			{
				"<Leader>dx",
				function()
					require("dap").step_out()
				end,
				desc = "DAP step out",
				mode = { "n" },
			},
			{
				"<Leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP toggle breakpoint",
				mode = { "n" },
			},
			{
				"<Leader>dv",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "DAP set logpoint",
				mode = { "n" },
			},
			{
				"<Leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "DAP REPL open",
				mode = { "n" },
			},
			{
				"<Leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "DAP run last",
				mode = { "n" },
			},
			{
				"<Leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "DAP hover",
				mode = { "n" },
			},
			{
				"<Leader>dp",
				function()
					require("dap.ui.widgets").preview()
				end,
				desc = "DAP preview",
				mode = { "n" },
			},
			{
				"<Leader>df",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end,
				desc = "DAP frames",
				mode = { "n" },
			},
			{
				"<Leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
				desc = "DAP scopes",
				mode = { "n" },
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
