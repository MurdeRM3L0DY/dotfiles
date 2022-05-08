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

return M[vim.loop.cwd()]
  or require('lua-dev').setup {
    library = {
      vimruntime = true,
      types = true,
      plugins = true,
    },
    runtime_path = true,
    lspconfig = defaults,
  }
