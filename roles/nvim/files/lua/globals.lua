local g = vim.g

-- Disable some builtin plugins
g.loaded_gzip = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrwPlugin = 1
g.loaded_remote_plugins = 1
g.loaded_shada_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_tarPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_zipPlugin = 1
g.loaded_man = 1
g.loaded_2html_plugin = 1

-- filetype.lua
g.did_load_filetypes = 0
g.do_filetype_lua = 1

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
