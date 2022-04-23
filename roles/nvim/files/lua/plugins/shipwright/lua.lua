local shipwright = require 'shipwright'
local overwrite = require 'shipwright.transform.overwrite'
local helpers = require 'shipwright.transform.helpers'
local palette = require('colorblind.theme').Colorblind.lush

local template = [[
local palette = $palette
return palette
]]

shipwright.run(palette, function(colors)
  local p = {}

  for theme, v in pairs(colors) do
    p[theme] = {}
    for color, t in pairs(v) do
      p[theme][color] = tostring(t)
    end
  end

  local text = helpers.apply_template(template, {
    palette = vim.inspect(p),
  })

  return helpers.split_newlines(text)
end, { overwrite, '/home/nemesis/.config/awesome/config/ui/palette.lua' })

vim.notify 'build complete'
