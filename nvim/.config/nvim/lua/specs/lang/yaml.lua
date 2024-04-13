return {
  {
    'nvim-lspconfig',
    ft = { 'yaml' },
    opts = {
      servers = {
        yamlls = {
          before_init = function(_, config)
            local schemas = require('schemastore').yaml.schemas()

            config.settings.yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = schemas
            }
          end
        },
      },
    },
  },

  {
    'mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'yaml-language-server' })
    end,
  },
}
