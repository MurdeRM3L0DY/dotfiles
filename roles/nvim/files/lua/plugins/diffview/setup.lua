local lazy = require 'utils.lazy'
local K = require 'utils.keymap'

---@module 'diffview.init'
local diffview = lazy.require 'diffview'

K.set('n', '<leader>do', function()
  diffview.open()
end)

K.set('n', '<leader>dc', function()
  diffview.close()
end)
