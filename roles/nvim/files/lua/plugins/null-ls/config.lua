local augroup = require 'utils.augroup'
local keymap = require 'utils.keymap'

local NULL_LS_AUGROUP = augroup('NULL_LS_AUGROUP', { clear = true })

local null = require 'null-ls'
local b = null.builtins

null.setup {
  debug = false,

  debounce = 50,

  sources = {
    b.formatting.stylua.with {
      condition = function(util)
        return util.root_has_file { '.stylua.toml', 'stylua.toml' }
      end,
    },
    b.formatting.rustfmt.with {
      condition = function(util)
        return util.root_has_file { 'rustfmt.toml' }
      end,
    },
    b.formatting.clang_format.with {
      condition = function(util)
        return util.root_has_file { '.clang-format' }
      end,
    },
    b.formatting.prettier_d_slim.with {
      only_local = './node_modules/.bin/',
    },
    b.formatting.black,
  },

  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      -- NULL_LS_AUGROUP(function(au)
      --   au.clear { buffer = bufnr }
      --
      --   au.create({ 'BufWritePost' }, {
      --     buffer = bufnr,
      --     callback = function()
      --       vim.lsp.buf.format()
      --     end,
      --   })
      -- end)

      keymap.set('n', '<leader>F', function()
        vim.lsp.buf.format { buffer = bufnr }
      end, { buffer = bufnr })
    end
  end,
}
