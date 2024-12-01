-- Set up leader to ensure correct mappings setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("custom/ensure_lazy")

vim.cmd([[source ~/.config/nvim/common.vim]])
vim.cmd([[
if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif
]])

require("lazy").setup({ import = "custom/plugins" }, {
	concurrency = 50,
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
			},
		},
	},
	change_detection = {
		notify = false,
	},
})
