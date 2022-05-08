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
