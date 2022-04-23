local K = require 'utils.keymap'

local telescope = function()
  return require 'telescope'
end

local builtin = function()
  return require 'telescope.builtin'
end

local themes = function()
  return require 'telescope.themes'
end

local with_ivy = function(opts)
  return themes().get_ivy(opts or {})
end

local find_files = function(opts)
  local find_command = { 'rg', '--files', '--ignore', '--hidden' }
  local defaults = { find_command = find_command }

  builtin().find_files(with_ivy(vim.tbl_extend('force', defaults, opts)))
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
  builtin().grep_string { search = vim.fn.input 'Search String -> ' }
end)

K.set('n', '<leader>fb', function()
  telescope().extensions.file_browser.file_browser()
end)

K.set('n', '<leader>cd', function()
  telescope().extensions.opener.opener {
    hidden = true,
  }
end)
