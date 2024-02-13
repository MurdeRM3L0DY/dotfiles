return {
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        vimruntime = true,
        types = true,
        plugins = true,
      },
      lspconfig = false,
    },
  },
  {
    'nvim-lspconfig',
    ft = { 'lua' },
    opts = {
      servers = {
        ['lua_ls'] = {
          before_init = function(...)
            require('neodev.lsp').before_init(...)
          end,
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              telemetry = {
                enable = false,
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
                showWord = 'Disable',
              },
              hint = {
                enable = true,
              },
            },
          },
        },
      },
    },
  },
  {
    'conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = {
        lua = { 'stylua' },
      }
    end,
  },
}
