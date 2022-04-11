local augroup = require 'utils.augroup'

augroup('HIGHLIGHT_ON_YANK', {})(function(autocmd, clear)
  clear {}

  autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank { timeout = 150, on_visual = false }
    end,
  })
end)
