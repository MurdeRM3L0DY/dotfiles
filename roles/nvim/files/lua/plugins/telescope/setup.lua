local lazy = require 'utils.lazy'
local keymap = require 'utils.keymap'

---@module 'telescope.init'
local telescope = lazy.require 'telescope'

---@module 'telescope.builtin'
local builtin = lazy.require 'telescope.builtin'

---@module 'telescope.themes'
local themes = lazy.require 'telescope.themes'

local ivy = function(opts)
  opts = opts or {}

  opts.borderchars = {
    prompt = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
    results = { ' ' },
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  }

  return themes.get_ivy(opts)
end

local dropdown = function(opts)
  opts = opts or {}

  opts.borderchars = {
    prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  }

  return themes.get_dropdown(opts)
end

local find_files = function(opts)
  local find_command = { 'rg', '--files', '--ignore', '--hidden' }
  local defaults = { find_command = find_command }

  builtin.find_files(ivy(vim.tbl_extend('force', defaults, opts)))
end

keymap.set('n', '<leader>ff', function()
  find_files {
    no_ignore = true,
  }
end)

keymap.set('n', '<leader>fn', function()
  find_files { cwd = vim.fn.stdpath 'config' }
end)

keymap.set('n', '<leader>fg', function()
  builtin.live_grep()
end)

keymap.set('n', '<leader>fb', function()
  telescope.extensions.file_browser.file_browser()
end)

keymap.set('n', '<leader>bb', function()
  builtin.buffers(dropdown())
end)

keymap.set('n', '<leader>cd', function()
  telescope.extensions.opener.opener {
    hidden = true,
  }
end)
