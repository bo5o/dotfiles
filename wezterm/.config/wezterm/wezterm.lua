local wezterm = require("wezterm")

return {
	font = wezterm.font("Iosevka Fixed SS14"),
	font_size = 12,
	line_height = 0.95,
	color_scheme = "Gruvbox dark, medium (base16)",
	enable_scroll_bar = false,
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	anti_alias_custom_block_glyphs = false,
	window_decorations = "RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}
