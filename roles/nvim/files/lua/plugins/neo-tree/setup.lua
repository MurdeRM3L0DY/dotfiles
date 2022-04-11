require('utils.keymap').set('n', '<C-p>', function()
  -- require('neo-tree').focus(nil, true, true)
  require('neo-tree.command').execute { source = 'filesystem', toggle = true }
end)
