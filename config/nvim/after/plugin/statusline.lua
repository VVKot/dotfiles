require'lualine'.setup {
    options = {
        theme = 'github_vkot',
        disabled_filetypes = {"fugitive", "startify"}
    },
    sections = {
        lualine_a = {"hostname"},
        lualine_b = {},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {require'lsp-status'.status},
        lualine_y = {'encoding', 'fileformat', 'filetype'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'location'}
    }
}
