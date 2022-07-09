local keymap = require 'utils.keymap'

keymap.set('n', [[<C-\>]], function()
  vim.api.nvim_cmd({ cmd = 'ToggleTerm', count = vim.v.count }, {})
  -- vim.api.nvim_cmd({ cmd = 'ToggleTerm', range = { vim.v.count } }, {})
  -- require('toggleterm').toggle(vim.v.count)
end)

keymap.set('n', '<leader>tt', '<cmd>ToggleTermToggleAll<cr>')
