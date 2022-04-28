local M = {}

M.ensure_modname = function(modname)
  local fullpath = vim.fn.stdpath 'config' .. ('/lua/%s.lua'):format(modname:gsub('[.]', '/'))
  if not vim.loop.fs_stat(fullpath) then
    return false
  end
  return true
end

return M
