local ui = require('utils.settings').ui
local signs = ui.signs

local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { '', '' },
    section_separators = { '', '' },
    disabled_filetypes = {},
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch' },
      { 'diff' },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
-- Inserts a component in lualine_c at left section

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end
--
-- -- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_right {
  'diagnostics',
  source = { 'nvim' },
  sections = { 'error', 'info', 'warn', 'hint' },
  symbols = {
    error = signs['Error'],
    warn = signs['Warn'],
    info = signs['Info'],
    hint = signs['Hint'],
  },
  update_in_insert = true,
}

require('lualine').setup(config)
