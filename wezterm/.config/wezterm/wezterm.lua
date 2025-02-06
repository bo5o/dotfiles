local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback({
    "Iosevka Fixed SS14",
    { family = "Symbols Nerd Font Mono", scale = 0.90 },
  }),
  font_size = 12,
  line_height = 1.00,
  color_scheme = "Gruvbox dark, medium (base16)",
  warn_about_missing_glyphs = false,
  enable_scroll_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
  front_end = "WebGpu",
  audible_bell = "Disabled",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
