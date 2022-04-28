local keymap = require 'utils.keymap'

local treehopper = function()
  return require 'tsht'
end

keymap.set({ 'n', 'o' }, 'm', function()
  treehopper().nodes()
end)
