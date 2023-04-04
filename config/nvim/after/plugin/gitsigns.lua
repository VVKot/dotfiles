require("gitsigns").setup({
  current_line_blame = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local opts = { buffer = bufnr }

    -- Navigation
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
    vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts)
    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)
    vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts)
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk_inline, opts)
    vim.keymap.set("n", "<leader>td", gs.toggle_deleted, opts)

    -- Text object
    vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
  end,
})
