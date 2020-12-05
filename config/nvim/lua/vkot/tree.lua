local settings = vim.g
local dummy_binding = "<Leader>000" -- need to fix upstream

settings.lua_tree_width = 60
settings.lua_tree_quit_on_open = 1
settings.lua_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
}
settings.lua_tree_bindings = {
  edit = { '<CR>', 'i' },
  edit_vsplit = 'a',
  edit_split = 'o',
  refresh = 'R',
  preview = 'p',

  edit_tab = dummy_binding,
  toggle_ignored = dummy_binding,
  toggle_dotfiles = dummy_binding,
  cd = dummy_binding,
  create = dummy_binding,
  remove = dummy_binding,
  rename = dummy_binding,
  cut = dummy_binding,
  copy = dummy_binding,
  paste = dummy_binding,
  prev_git_item = dummy_binding,
  next_git_item = dummy_binding,
}

