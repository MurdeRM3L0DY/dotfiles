-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

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
        runtime = {
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          -- library = {
          --   ['/usr/local/awesome/lib'] = true,
          -- },
        },
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
