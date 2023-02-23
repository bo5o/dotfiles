local wezterm = require("wezterm")

local ssh_domains = {}

for host, config in pairs(wezterm.enumerate_ssh_hosts()) do
  table.insert(ssh_domains, {
    name = host,
    remote_address = host,
    multiplexing = "None",
    assume_shell = "Posix",
  })
end

return {
  font = wezterm.font("Iosevka Term SS14"),
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  font_size = 13.5,
  line_height = 1.1,
  allow_square_glyphs_to_overflow_width = "Never",
  color_scheme = "Gruvbox dark, medium (base16)",
  enable_scroll_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  -- window_background_opacity = 0.85,
  -- text_background_opacity = 0.85,
  keys = {
    {
      key = "n",
      mods = "ALT",
      action = wezterm.action.ShowLauncherArgs({ flags = "DOMAINS" }),
    },
    {
      key = "l",
      mods = "ALT",
      action = wezterm.action.ShowLauncher,
    },
  },
  ssh_domains = ssh_domains,
  unix_domains = {},
}
