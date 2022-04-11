local ui = require('utils.settings').ui

for t, icon in pairs(ui.signs) do
  local hl = 'DiagnosticSign' .. t
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,

  -- virtual_text = {
  --   prefix = '',
  --   spacing = 4,
  --   source = true,
  -- },
  virtual_text = false,
  signs = true,
  underline = true,
  float = {
    border = 'single',
    header = '',
    source = true,
  },
}

vim.diagnostic.open_float = (function(open_float)
  return function(opts)
    -- local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    -- -- A more robust solution would check the "scope" value in `opts` to
    -- -- determine where to get diagnostics from, but if you're only using
    -- -- this for your own purposes you can make it as simple as you like
    -- local diagnostics = vim.diagnostic.get(opts.bufnr, { lnum = lnum })
    -- local max_severity = vim.diagnostic.severity.HINT
    -- for _, d in ipairs(diagnostics) do
    --   -- Equality is "less than" based on how the severities are encoded
    --   if d.severity < max_severity then
    --     max_severity = d.severity
    --   end
    -- end
    -- local border_color = ({
    --   [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    --   [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    --   [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
    --   [vim.diagnostic.severity.ERROR] = "DiagnosticError",
    -- })[max_severity]
    -- opts.border = {
    --   { "🭽", border_color },
    --   { "▔", border_color },
    --   { "🭾", border_color },
    --   { "▕", border_color },
    --   { "🭿", border_color },
    --   { "▁", border_color },
    --   { "🭼", border_color },
    --   { "▏", border_color },
    -- }
    open_float(opts)
  end
end)(vim.diagnostic.open_float)
