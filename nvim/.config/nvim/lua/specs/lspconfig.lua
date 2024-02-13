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
      local make_config = require('utils.lsp').make_config
      local lspconfig = require('lspconfig')

      require('config.lsp.keys').update(opts.keys or {})

      for name, config in pairs(opts.servers) do
        lspconfig[name].setup(make_config(config))
      end
    end,
  },
}
