local augroup = require 'utils.augroup'

augroup('HIGHLIGHT_ON_YANK', { clear = true })(function(autocmd, clear)
  autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank { timeout = 150 }
    end,
  })
end)
