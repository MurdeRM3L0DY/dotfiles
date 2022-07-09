local lazy = require 'utils.lazy'
local keymap = require 'utils.keymap'

---@module "tsht"
local treehopper = lazy.require 'tsht'

keymap.set({ 'n', 'o' }, 'm', function()
  treehopper.nodes()
end)
