return {
  {
    'nvim-lspconfig',
    ft = {
      'kotlin',
    },
    dependencies = {
      {
        'mason.nvim',
        opts = function(_, opts)
          table.insert(opts.ensure_installed, 'kotlin-language-server')
        end,
      },
    },
    opts = {
      servers = {
        kotlin_language_server = {},
      },
    },
  },
}
