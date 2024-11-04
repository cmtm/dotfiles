local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Selenized Dark (Gogh)'
config.default_prog = { '/usr/bin/nu' }
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 100000
config.enable_kitty_keyboard = true

return config
