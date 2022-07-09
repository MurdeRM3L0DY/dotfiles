local create_autocmd = vim.api.nvim_create_autocmd

create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 150, on_visual = false }
  end,
  desc = 'nvim/lua/autocmds.lua:3'
})
