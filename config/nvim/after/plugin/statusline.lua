-- Needs a custom function to prevent unnecessary shortening of the path
local function full_filename()
  local data = vim.fn.expand("%:~:.")
  if vim.bo.modified then
    data = data .. " [+]"
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    data = data .. " [-]"
  end
  return data
end

require("lualine").setup({
  options = {
    theme = "github_vkot",
    disabled_filetypes = { "fugitive", "startify" },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { full_filename } },
    lualine_x = { "diagnostics" },
    lualine_y = { "encoding", "fileformat", "filetype" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { full_filename } },
    lualine_x = { "diagnostics" },
    lualine_y = {},
    lualine_z = { "location" },
  },
})
