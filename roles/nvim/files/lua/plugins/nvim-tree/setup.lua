local lazy = require 'utils.lazy'
local keymap = require 'utils.keymap'

---@module "nvim-tree"
local nvim_tree = lazy.require 'nvim-tree'

keymap.set('n', '<leader>e', function()
  nvim_tree.toggle()
end)
