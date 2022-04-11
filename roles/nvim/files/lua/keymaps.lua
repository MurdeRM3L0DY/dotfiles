local K = require 'utils.keymap'

-- Leader Key
K.set('n', '<space>', '<nop>')
vim.g.mapleader = K.t '<space>'

K.set('n', '<leader><leader>x', '<cmd>source %<cr>')

-- <C-w> keymaps
K.set('n', '<C-h>', '<C-w><C-h>')
K.set('n', '<C-j>', '<C-w><C-j>')
K.set('n', '<C-k>', '<C-w><C-k>')
K.set('n', '<C-l>', '<C-w><C-l>')
K.set('n', '<A-h>', '<C-w><')
K.set('n', '<A-j>', '<C-w>-')
K.set('n', '<A-k>', '<C-w>+')
K.set('n', '<A-l>', '<C-w>>')

K.set('n', '<C-q>', '<cmd>q<cr>')
K.set('n', '<C-s>', '<cmd>w<cr>')
K.set('n', '<leader>cj', '<cmd>cnext<cr>')
K.set('n', '<leader>ck', '<cmd>cprevious<cr>')

K.set('v', '<', '<gv')
K.set('v', '>', '>gv')

K.set('t', '<esc>', [[<C-\><C-n>]])
