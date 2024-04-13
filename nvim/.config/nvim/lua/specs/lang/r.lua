return {
  {
    'nvim-lspconfig',
    ft = { 'r', 'rmd' },
    opts = {
      servers = {
        r_language_server = {
          cmd = { 'r-languageserver' }
        },
      },
    },
  },

  {
    'mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'r-languageserver', 'marksman' })
    end,
  },
}
