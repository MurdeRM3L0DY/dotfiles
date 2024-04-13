return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason.nvim' },
      { 'neoconf.nvim' },
    },
    opts = {
      servers = {},
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      local c = require('config.lsp')

      c.update_keys(opts.keys)

      for name, config in pairs(opts.servers) do
        lspconfig[name].setup(c.make_client_config(config))
      end
    end,
  },
}
