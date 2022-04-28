local compleet = require 'compleet'
local keymap = require 'utils.keymap'

-- compleet.setup {
--   ui = {
--     menu = {
--       border = {
--         -- style = 'single',
--         style = { '+', 'x' },
--       },
--     },
--     details = {
--       border = {
--         -- style = { '/', '-', '\\', '|' },
--         style = { '+', 'x' },
--         -- style = 'shadow',
--       },
--     },
--
--     hint = {
--       enable = false,
--     },
--   },
--   completion = {
--     while_deleting = true,
--   },
--   sources = {
--     lipsum = {
--       enable = false,
--     },
--     lsp = {
--       enable = true,
--       test = '',
--     },
--   },
-- }

local tab = function()
  return (compleet.is_menu_open() and '<Plug>(compleet-next-completion)')
    or (compleet.has_completions() and '<Plug>(compleet-show-completions)')
    or '<Tab>'
end

local s_tab = function()
  return compleet.is_menu_open() and '<Plug>(compleet-prev-completion)' or '<S-Tab>'
end

local right = function()
  return compleet.is_hint_visible() and '<Plug>(compleet-insert-hinted-completion)' or '<Right>'
end

local cr = function()
  return compleet.is_completion_selected() and '<Plug>(compleet-insert-selected-completion)'
    or '<CR>'
end

local opts = { noremap = false }

keymap.set('i', '<Tab>', tab, opts)
keymap.set('i', '<S-Tab>', s_tab, opts)
keymap.set('i', '<Right>', right, opts)
keymap.set('i', '<CR>', cr, opts)
