local M = {}

local uv = vim.loop
local HOME = os.getenv 'HOME'

M.ui = {
  border = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' },
  },
  signs = {
    Error = ' ',
    Warn = ' ',
    Hint = '',
    Info = ' ',
  },
}

M.env = {
  PYTHON_HOST = '',
  NODE_HOST = '',
  SERVERS_DIR = uv.fs_realpath(HOME .. '/dev/langservers'),
}

return M
