local M = {}

M.setup = function()
	vim.g.obsidian = 1
	local obsidian = require("obsidian")

	vim.keymap.set("n", "<C-]>", "<cmd>ObsidianFollowLink<CR>")
	vim.keymap.set("n", "<C-t>", "<C-o>")
	vim.keymap.set("n", "<Leader><Leader>", "<cmd>ObsidianSearch<CR>")
	vim.keymap.set("n", "gzz", "<cmd>ObsidianSearch<CR>")
	vim.keymap.set("n", "gzb", "<cmd>ObsidianBacklinks<CR>")
	vim.keymap.set("n", "gzl", "<cmd>ObsidianLinks<CR>")
	vim.keymap.set("n", "gzo", "<cmd>ObsidianOpen<CR>")
	vim.keymap.set("n", "gzn", function()
		vim.cmd.ObsidianNew()
		vim.cmd.ObsidianTemplate({ args = { "template.md" } })
	end)
	vim.keymap.set("n", "gzt", function()
		vim.cmd.ObsidianTags()
	end)

	vim.o.textwidth = 80

	local function get_random_note_id()
		local note_id = {}
		for i = 1, 8 do
			note_id[i] = string.format("%x", math.random(0, 0xf))
		end
		return table.concat(note_id)
	end

	local function note_exists(name)
		local f = io.open(name .. ".md", "r")
		if f ~= nil then
			io.close(f)
			return true
		end
		local fd = io.open("books/" .. name .. ".md", "r")
		return fd ~= nil and io.close(fd)
	end

	obsidian.setup({
		open_app_foreground = true,

		completion = {
			nvim_cmp = false,
		},

		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
		-- mimic ids from neuron
		note_id_func = function()
			local id = get_random_note_id()
			while note_exists(id) do
				id = get_random_note_id()
			end
			return id
		end,
		disable_frontmatter = true,
		log_level = vim.log.levels.WARN,

		mappings = {},
		workspaces = {
			{
				name = "no-vault",
				path = function()
					return assert(vim.fn.getcwd())
				end,
			},
		},
	})
end

return M
