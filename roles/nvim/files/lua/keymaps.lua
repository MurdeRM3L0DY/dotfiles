local keymap = require 'utils.keymap'

-- Leader Key
keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = keymap.t '<space>'

keymap.set('n', '<leader><cr>', '<cmd>source %<cr>')

-- <C-w> keymaps
keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')
keymap.set('n', '<C-l>', '<C-w>l')
keymap.set('n', '<C-M-h>', '<C-w>H')
keymap.set('n', '<C-M-j>', '<C-w>J')
keymap.set('n', '<C-M-k>', '<C-w>K')
keymap.set('n', '<C-M-l>', '<C-w>L')
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
