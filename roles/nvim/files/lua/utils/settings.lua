local M = {}

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
    Error = '',
    Warn = '',
    Hint = '',
    Info = '',
  },
}

M.env = {
  PYTHON_HOST = '',
  NODE_HOST = '',
}

return M
