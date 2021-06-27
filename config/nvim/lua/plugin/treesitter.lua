local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = "all",
    ignore_install = {"haskell"},
    highlight = {enable = true, use_languagetree = true},
    indent = {enable = true},
    refactor = {
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = false}
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            }
        }
    },
    textsubjects = {
        enable = true,
        keymaps = {["<C-\\>"] = "textsubjects-smart"}
    },
    context_commentstring = {enable = true, enable_autocmd = false},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<M-w>',
            node_incremental = '<M-w>',
            scope_incremental = '<M-e>',
            node_decremental = '<M-C-w>'
        }
    }
}
