local awful = require 'awful'
local gears = require 'gears'
local naughty = require 'naughty'
local wibox = require 'wibox'
local debug = require 'gears.debug'
local gtk = require 'beautiful.gtk'
local palette = require 'config.ui.palette'

local theme = {}
theme.gtk = gtk.get_theme_variables()

local mywibox = wibox {}

-- awful.popup {
--   border_color = palette.colorblind.blue,
--   border_width = 1,
--   placement = awful.placement.bottom_right,
--   shape = gears.shape.rectangle,
--   visible = true,
--   ontop = true,
--   hide_on_right_click = true,
--   widget = {
--     text = debug.dump_return(mywibox),
--     widget = wibox.widget.textbox,
--     clip = true,
--     shape = gears.shape.rectangle,
--   },
-- }
