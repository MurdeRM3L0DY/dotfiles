local K = require 'utils.keymap'

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

K.set('n', '<leader>bc', '<cmd>BufferLinePickClose<cr>')
K.set('n', '<leader>j', '<cmd>BufferLineCycleNext<cr>')
K.set('n', '<leader>k', '<cmd>BufferLineCyclePrev<cr>')
K.set('n', '<leader>bb', '<cmd>BufferLinePick<cr>')
