return {
  {
    'nvim-lspconfig',
    ft = {
      'go',
      'gomod',
    },
    dependencies = {
      {
        'mason.nvim',
        opts = function(_, opts)
          table.insert(opts.ensure_installed, 'gopls')
        end,
      },
    },
    opts = {
      servers = {
        gopls = {},
      },
    },
  },
}
