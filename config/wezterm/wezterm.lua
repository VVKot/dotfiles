local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font({ family = "JetBrains Mono" })
config.font_size = 14

config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = "iTerm2 Light Background"

-- https://github.com/mbadolato/iTerm2-Color-Schemes/blob/9e0830e15a498740b95d63939c39bc8bc5f81dc0/wezterm/iTerm2%20Light%20Background.toml#L1-L12
local colors = {
	foreground = "#000000",
	background = "#ffffff",
	selection_bg = "#c1deff",
	selection_fg = "#000000",
}
config.colors = {
	tab_bar = {
		inactive_tab_edge = colors.foreground,
		background = colors.background,
		active_tab = {
			bg_color = colors.selection_bg,
			fg_color = colors.foreground,
		},
		inactive_tab = {
			bg_color = colors.background,
			fg_color = colors.foreground,
		},
		inactive_tab_hover = {
			bg_color = colors.selection_bg,
			fg_color = colors.selection_fg,
		},
		new_tab = {
			bg_color = colors.background,
			fg_color = colors.foreground,
		},
		new_tab_hover = {
			bg_color = colors.selection_bg,
			fg_color = colors.selection_fg,
		},
	},
}
config.window_frame = {
	font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
	font_size = 14.0,
	active_titlebar_bg = colors.background,
	inactive_titlebar_bg = colors.background,
}

return config
