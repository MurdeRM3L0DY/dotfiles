local augroup = require('utils.augroup')

local USER_AUGROUP = augroup('USER_AUGROUP', {})

USER_AUGROUP(function(au)
  au.create('FileType', {
    pattern = {
      'c',
      'cpp',
      'lua',
      'java',
      'rust',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    callback = function()
      vim.opt_local.formatoptions:remove { 'o' }
    end,
  })

  au.create('TextYankPost', {
    callback = function()
      vim.highlight.on_yank { timeout = 200, higroup = 'OnYank' }
    end,
  })

  -- 4 indent space
  au.create('FileType', {
    pattern = { 'c', 'cpp', 'groovy', 'java', 'kotlin', 'python', 'rust' },
    callback = function(_)
      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = true
    end,
  })

  au.create('FileType', {
    pattern = { 'asm' },
    callback = function(_)
      vim.opt_local.relativenumber = false
      vim.opt_local.number = true
    end,
  })

  au.create('FileType', {
    pattern = { 'blif' },
    callback = function(_)
      vim.opt_local.textwidth = 1000
    end,
  })
end)

if vim._watch then
  local palette_path = vim.fn.stdpath('config') .. '/lua/utils/palette.lua'
  vim._watch.watch(palette_path, {}, function(_, e)
    if e == vim._watch.FileChangeType.Changed then
      vim.schedule(function()
        vim.api.nvim_exec_autocmds('User', {
          group = USER_AUGROUP.id,
          pattern = 'Flavours',
        })
      end)
    end
  end)
end

return USER_AUGROUP
