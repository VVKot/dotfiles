if vim.fn.executable("neuron") == 1 then
    require"neuron".setup {
        virtual_titles = true,
        mappings = true,
        run = function()
            vim.cmd [[set textwidth=80]]
            vim.cmd [[set spell]]
        end, -- function to run when in neuron dir
        neuron_dir = "~/zettelkasten", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
        leader = "gz" -- the leader key to for all mappings, remember with 'go zettel'
    }
end
