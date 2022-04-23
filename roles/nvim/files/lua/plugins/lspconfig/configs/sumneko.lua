local lua_dev = require('lua-dev').setup {
  library = {
    vimruntime = true,
    types = true,
    plugins = true,
  },
  runtime_path = true,
  lspconfig = {
    settings = {
      Lua = {
        -- runtime = {
        --   path = { 'lua/?.lua', 'lua/?/init.lua' },
        -- },
        -- workspace = {
        --   library = vim.api.nvim_get_runtime_file('', true)
        -- },
        completion = {
          showWord = 'Disable',
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

return lua_dev
