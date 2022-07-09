local keymap = require 'utils.keymap'
local lazy = require 'utils.lazy'

---@module 'hop'
local hop = lazy.require 'hop'

keymap.set('n', '<leader>hl', function()
  hop.hint_lines()
end)

keymap.set('n', '<leader>hc', function()
  hop.hint_char1()
end)
