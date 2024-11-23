local M = {}

M.setup = function()
  local telescope = require("telescope")

  local actions = require("telescope.actions")
  local action_layout = require("telescope.actions.layout")
  local insert_mappings = {
    ["<M-t>"] = action_layout.toggle_preview,
  }
  local normal_mappings = {
    ["<M-t>"] = action_layout.toggle_preview,
    ["<C-c>"] = actions.close,
  }

  telescope.setup({
    defaults = {
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
      layout_strategy = "flex",
      scroll_strategy = "cycle",
      mappings = { i = insert_mappings, n = normal_mappings },
      path_display = {
        "filename_first",
      },
    },
    pickers = {
      buffers = { sort_mru = true },
      diagnostics = { path_display = "hidden" },
    },
    extensions = {
      fzf = { override_generic_sorter = true, override_file_sorter = true },
    },
  })

  telescope.load_extension("fzf")

  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<Leader><Leader>", function()
    local is_inside_work_tree = {}
    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
      vim.fn.system("git rev-parse --is-inside-work-tree")
      is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
      builtin.git_files({})
    else
      builtin.find_files({})
    end
  end, {
    desc = "Telescope git files/files",
  })
  vim.keymap.set("n", "<Leader>ft", function()
    builtin.builtin({
      previewer = false,
    })
  end, {
    desc = "Telescope built-in",
  })
  vim.keymap.set("n", "<Leader>ff", function()
    builtin.live_grep({})
  end, {
    desc = "Telescope live grep",
  })
  vim.keymap.set("n", "<Leader>fs", function()
    builtin.grep_string({ search = vim.fn.input(":RG "), use_regex = true })
  end, {
    desc = "Telescope search",
  })
  vim.keymap.set("n", "<Leader>gs", function()
    builtin.git_status({})
  end, {
    desc = "Telescope git status",
  })
  vim.keymap.set("n", "<Leader>fb", function()
    builtin.buffers({})
  end, {
    desc = "Telescope buffers",
  })
end

return M
