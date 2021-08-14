require("zen-mode").setup {
    window = {
        width = 121,
        height = .9,
        options = {signcolumn = "no", number = false, relativenumber = false}
    },
    plugins = {
        options = {enabled = true, showcmd = false},
        gitsigns = {enabled = true},
        tmux = {enabled = true}
    }
}

local nnoremap = vim.keymap.nnoremap
nnoremap {"<Leader>zz", function() vim.api.nvim_command [[ZenMode]] end}
