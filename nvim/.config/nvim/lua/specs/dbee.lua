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
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require('dbee').install()
  end,
  config = function()
    require('dbee').setup {
      sources = {
        require('dbee.sources').EnvSource:new('DBEE_CONNECTIONS'),
      },
    }
  end,
}
