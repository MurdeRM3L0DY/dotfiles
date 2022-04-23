local K = require 'utils.keymap'

local null = require 'null-ls'
local b = null.builtins

null.setup {
  debug = false,

  sources = {
    b.formatting.stylua.with {
      condition = function(util)
        return util.root_has_file { '.stylua.toml', 'stylua.toml' }
      end,
    },
    -- b.formatting.stylua,
    b.formatting.rustfmt.with {
      condition = function(util)
        return util.root_has_file { 'rustfmt.toml' }
      end
    },
    b.formatting.clang_format.with {
      condition = function(util)
        return util.root_has_file { '.clang-format' }
      end,
    },
    -- b.formatting.prettier_d_slim.with {
    --   only_local = './node_modules/.bin/',
    -- },
  },

  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      K.set('n', '<leader>F', function()
        local params = vim.lsp.util.make_formatting_params()
        client.request('textDocument/formatting', params, nil, bufnr)
      end, { buffer = bufnr })
    end
  end,
}
