return {
  'kndndrj/nvim-dbee',
  keys = {
    {
      '<leader>db',
      function()
        require('dbee').toggle()
      end,
      mode = { 'n' },
    },
  },
  config = function()
    require('dbee').setup {
      sources = {
        require('dbee.sources').EnvSource:new('DBEE_CONNECTIONS'),
      },
    }
  end,
}
