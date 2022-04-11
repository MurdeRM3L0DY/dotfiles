require('neorg').setup {
  load = {
    ['core.defaults'] = {},
    ['core.norg.concealer'] = {},
    ['core.integrations.nvim-cmp'] = {},
    ['core.integrations.treesitter'] = {
      config = {
        configure_parsers = true,
      },
    },
    ['core.norg.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
  },
}
