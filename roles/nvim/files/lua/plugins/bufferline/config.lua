local keymap = require 'utils.keymap'

require('bufferline').setup {
  options = {
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'center',
        highlight = 'Directory',
      },
    },
  },
}

keymap.set('n', '<leader>bc', '<cmd>BufferLinePickClose<cr>')
keymap.set('n', '<leader>j', '<cmd>BufferLineCycleNext<cr>')
keymap.set('n', '<leader>k', '<cmd>BufferLineCyclePrev<cr>')
keymap.set('n', '<leader>bb', '<cmd>BufferLinePick<cr>')
