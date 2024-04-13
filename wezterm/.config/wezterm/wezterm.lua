-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

config.font = wezterm.font("Cartograph CF")
config.enable_tab_bar = false

config.window_padding = {
	-- left = '0cell',
	-- right = '0cell',
	-- top = '0cell',
	-- bottom = '0cell',
}

-- and finally, return the configuration to wezterm
return config
