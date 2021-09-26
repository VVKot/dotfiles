-- Adapted from https://github.com/projekt0n/github-nvim-theme/blob/main/lua/lualine/themes/github.lua
local colors = {fg = "#24292e", bg = "#ffffff", blue = "#0451a5"}

local section_color = {bg = colors.bg, fg = colors.fg}
local section_color_bold = {bg = colors.bg, fg = colors.fg, gui = "bold"}
local section_color_highlighed = {bg = colors.blue, fg = colors.bg}

local active_sections = {
    a = section_color_highlighed,
    b = section_color,
    c = section_color_bold,
    x = section_color,
    y = section_color,
    z = section_color_highlighed
};
local inactive_sections = {
    a = section_color,
    b = section_color,
    c = section_color_bold,
    x = section_color,
    y = section_color,
    z = section_color
};
return {
    normal = active_sections,
    insert = active_sections,
    command = active_sections,
    visual = active_sections,
    replace = active_sections,
    inactive = inactive_sections
}
