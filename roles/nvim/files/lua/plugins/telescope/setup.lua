local K = require 'utils.keymap'

local with_ivy = function(opts)
  return require('telescope.themes').get_ivy(opts or {})
end

local find_files = function(opts)
  local find_command = { 'rg', '--files', '--ignore', '--hidden' }
  local defaults = { find_command = find_command }

  require('telescope.builtin').find_files(with_ivy(vim.tbl_extend('force', defaults, opts)))
end

K.set('n', '<leader>ff', function()
  find_files {
    no_ignore = true,
  }
end)

K.set('n', '<leader>fn', function()
  find_files { cwd = vim.fn.stdpath 'config' }
end)

K.set('n', '<leader>fs', function()
  require('telescope.builtin').grep_string { search = vim.fn.input 'Search String -> ' }
end)

K.set('n', '<leader>fb', function()
  require('telescope').extensions.file_browser.file_browser()
end)

K.set('n', '<leader>cd', function()
  require('telescope').extensions.opener.opener {
    hidden = true,
  }
end)
