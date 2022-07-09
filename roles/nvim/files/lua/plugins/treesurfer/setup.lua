local lazy = require 'utils.lazy'
local keymap = require 'utils.keymap'

---@module 'syntax-tree-surfer'
local treesurfer = lazy.require 'syntax-tree-surfer'

-- Normal Mode Swapping
-- K.set('n', 'vd', function()
--   treesurfer().move('n', false)
-- end)
--
-- K.set('n', 'vu', function()
--   treesurfer().move('n', true)
-- end)
--
-- -- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
-- K.set('n', 'vx', function()
--   treesurfer().select()
-- end)
-- -- .select_current_node() will select the current node at your cursor
-- K.set('n', 'vn', function()
--   treesurfer().select_current_node()
-- end)

-- NAVIGATION: Only change the keymap to your liking. I would not recommend changing anything about the .surf() parameters!
keymap.set('x', 'J', function()
  treesurfer.surf('next', 'visual')
end)

keymap.set('x', 'K', function()
  treesurfer.surf('prev', 'visual')
end)

keymap.set('x', 'H', function()
  treesurfer.surf('parent', 'visual')
end)

keymap.set('x', 'L', function()
  treesurfer.surf('child', 'visual')
end)

-- SWAPPING WITH VISUAL SELECTION: Only change the keymap to your liking. Don't change the .surf() parameters!
keymap.set('x', '<A-j>', function()
  treesurfer.surf('next', 'visual', true)
end)

keymap.set('x', '<A-k>', function()
  treesurfer.surf('prev', 'visual', true)
end)
