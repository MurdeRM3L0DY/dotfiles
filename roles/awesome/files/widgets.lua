local awful = require 'awful'
local wibox = require 'wibox'
local palette = require 'ui.palette'
local screen = require 'awful.screen'

local bg = wibox.widget {
  {
    {
      text = 'foo',
      widget = wibox.widget.textbox,
    },
    {
      text = 'bar',
      widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.vertical,
  },
  bg = '#ff0000',
  widget = wibox.container.background,
}

-- local mywibox = wibox.widget {
--   x = 500,
--   y = 500,
--   width = 700,
--   height = 250,
-- }
--
-- mywibox:setup {
--   layout = wibox.layout.fixed.horizontal,
-- }

bg:setup {
  layout = wibox.layout.fixed.horizontal,
}
