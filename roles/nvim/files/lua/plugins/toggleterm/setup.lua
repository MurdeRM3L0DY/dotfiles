local keymap = require 'utils.keymap'

local toggleterm = function()
  return require 'toggleterm'
end

keymap.set('n', '<leader>tt', function()
  toggleterm().toggle_all()
end)
