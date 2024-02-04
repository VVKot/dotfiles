require("obsidian").setup({
  detect_cwd = true,
  open_app_foreground = true,

  completion = {
    nvim_cmp = false,
  },

  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
  },
  note_id_func = function()
    return os.date("%Y%m%d%H%M", os.time())
  end,
  disable_frontmatter = true,

  mappings = {},
})
