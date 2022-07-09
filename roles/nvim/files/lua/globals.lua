local g = vim.g

-- Disable some builtin plugins
local builtins = {
  'gzip',
  'matchit',
  'matchparen',
  'netrwPlugin',
  'remote_plugins',
  'shada_plugin',
  'spellfile_plugin',
  'tarPlugin',
  'tutor_mode_plugin',
  'zipPlugin',
  'man',
  '2html_plugin',
}

for _, builtin in ipairs(builtins) do
  g['loaded_' .. builtin] = 1
end

_G.P = function(...)
  return vim.pretty_print(...)
end

_G.RELOAD = function(...)
  require('plenary.reload').reload_module(...)
end

_G.R = function(name)
  RELOAD(name)
  return require(name)
end
