local telescope = require("telescope")

local actions = require("telescope.actions")
local mappings = {
    ["j"] = false,
    ["k"] = false,
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
    ["<A-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
    ["<esc>"] = actions.close
}

telescope.setup {
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {prompt_position = "top"},
        prompt_prefix = "🔭",
        scroll_strategy = "cycle",
        mappings = {i = mappings, n = mappings},
        winblend = 10
    },
    pickers = {
        buffers = {sort_lastused = true},
        builtin = {include_extensions = true},
        git_files = {show_untracked = false},
        lsp_code_actions = {theme = "dropdown", layout_config = {width = 0.6}},
        lsp_range_code_actions = {
            theme = "dropdown",
            layout_config = {width = 0.6}
        },
        spell_suggest = {theme = "dropdown", layout_config = {width = 0.6}}
    },
    extensions = {
        fzf = {override_generic_sorter = true, override_file_sorter = true},
        bookmarks = {
            selected_browser = "google_chrome",
            url_open_plugin = "open_browser"
        }
    }

}

telescope.load_extension("bookmarks")
telescope.load_extension("ultisnips")
telescope.load_extension("fzf")

local nnoremap = vim.keymap.nnoremap
local builtin = require("telescope.builtin")

nnoremap {'<Leader><C-t>', function() builtin.git_files {} end}
nnoremap {'<Leader><Leader>', function() builtin.git_files {} end}
nnoremap {'<Leader>tt', function() builtin.builtin {} end}
nnoremap {
    '<Leader>ft',
    function() builtin.grep_string {search = vim.fn.input(":RG ")} end
}
nnoremap {'<Leader>gt', function() builtin.git_status {} end}
nnoremap {'<Leader>lq', function() builtin.quickfix {} end}
nnoremap {'<Leader>ll', function() builtin.loclist {} end}
nnoremap {
    '<Leader>f<Leader>', function() builtin.current_buffer_fuzzy_find {} end
}
nnoremap {'<Leader>fb', function() builtin.buffers({}) end}
nnoremap {'<Leader>fm', function() builtin.marks {} end}
nnoremap {'<Leader>fw', function() builtin.grep_string {} end}
nnoremap {'<Leader>f:', function() builtin.command_history {} end}
nnoremap {'<Leader>f/', function() builtin.search_history {} end}
nnoremap {'z=', function() builtin.spell_suggest {} end}
