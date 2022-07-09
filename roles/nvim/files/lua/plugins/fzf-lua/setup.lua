local lazy = require 'utils.lazy'
local keymap = require 'utils.keymap'

---@module 'fzf-lua'
local fzf = lazy.require 'fzf-lua'

keymap.set('n', '<c-p>', function()
  fzf.files()
end)
