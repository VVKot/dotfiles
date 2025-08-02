if vim.g.vscode then
	return {}
end

return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
	end,
}
