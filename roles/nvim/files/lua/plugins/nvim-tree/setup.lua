local keymap = require 'utils.keymap'

local nvim_tree = function()
  return require 'nvim-tree'
end

keymap.set('n', '<leader>e', function()
  nvim_tree().toggle()
end)
