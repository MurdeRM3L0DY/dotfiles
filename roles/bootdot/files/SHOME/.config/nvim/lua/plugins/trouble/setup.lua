local K = require 'utils.keymap'

K.set('n', '<leader>xx', function()
  require('trouble').toggle()
end)

K.set('n', '<leader>xd', function()
  require('trouble').toggle { mode = 'lsp_document_diagnostics' }
end)
