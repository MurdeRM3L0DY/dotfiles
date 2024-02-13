return {
  'folke/trouble.nvim',
  keys = {
    {
      '<leader>xx',
      function()
        require('trouble').toggle()
      end,
      mode = { 'n' },
    },

    {
      '<leader>xd',
      function()
        require('trouble').toggle { mode = 'lsp_document_diagnostics' }
      end,
      mode = { 'n' },
    },
  },
  config = function()
    require('trouble').setup {}
  end,
}
