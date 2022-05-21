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
  diagnostics = {
    Error = '',
    Warn = '',
    Hint = '',
    Info = '',
  },
  git = {
    added = '', -- 
    changed = '',
    deleted = '' -- 
  }
}

M.env = {
  PYTHON_HOST = '',
  NODE_HOST = '',
}

return M
