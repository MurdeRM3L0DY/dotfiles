local M = {}

local dots = function(config)
  return ('%s/roles/%s/files'):format(os.getenv 'HOME' .. '/dotfiles', config)
end

local defaults = {
  settings = {
    Lua = {
      completion = {
        showWord = 'Disable',
      },
      -- workspace = {
      --   library = vim.api.nvim_get_runtime_file('', true)
      -- },
      telemetry = {
        enable = false,
      },
    },
  },
}

M[dots 'awesome'] = vim.tbl_extend('force', defaults, {
  settings = {
    Lua = {
      workspace = {
        library = {
          -- '~/.config/awesome/',
          '/usr/local/share/awesome/lib/',
        },
      },
    },
  },
})

local lua_dev = require('lua-dev').setup {
  library = {
    vimruntime = true,
    types = true,
    plugins = true,
  },
  runtime_path = true,
  lspconfig = defaults,
}

return M[vim.loop.cwd()] or lua_dev
