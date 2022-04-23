local K = require 'utils.keymap'

local treehopper = function()
  return require 'tsht'
end

K.set({'n', 'o'} , 'm', function()
  treehopper().nodes()
end)
