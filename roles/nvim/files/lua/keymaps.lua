local keymap = require 'utils.keymap'

-- Leader Key
keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = keymap.t '<space>'

keymap.set('n', '<leader><leader>x', '<cmd>source %<cr>')

-- <C-w> keymaps
keymap.set('n', '<C-h>', '<C-w><C-h>')
keymap.set('n', '<C-j>', '<C-w><C-j>')
keymap.set('n', '<C-k>', '<C-w><C-k>')
keymap.set('n', '<C-l>', '<C-w><C-l>')
keymap.set('n', '<A-h>', '<C-w><')
keymap.set('n', '<A-j>', '<C-w>-')
keymap.set('n', '<A-k>', '<C-w>+')
keymap.set('n', '<A-l>', '<C-w>>')

keymap.set('n', '<C-q>', '<cmd>q<cr>')
keymap.set('n', '<C-s>', '<cmd>w<cr>')
keymap.set('n', '<leader>cj', '<cmd>cnext<cr>')
keymap.set('n', '<leader>ck', '<cmd>cprevious<cr>')

keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

keymap.set('t', '<esc>', [[<C-\><C-n>]])
