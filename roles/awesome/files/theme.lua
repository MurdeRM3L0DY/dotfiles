local palette = require 'config.ui.palette'
local theme = {}

theme.wallpaper = os.getenv 'HOME' .. '/Pictures/city-of-japan-wallpaper.jpg'

theme.bg_normal = palette.colorblind.black

theme.font_name = 'CaskaydiaCove Nerd Font'
theme.taglist_bg_focus = palette.catppuccin.blue
theme.taglist_fg_focus = palette.catppuccin.black0

return theme
