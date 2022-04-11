local null = require 'null-ls'
local b = null.builtins
local augroup = require 'utils.augroup'
local NULL_LS_AUGROUP = augroup('NULL_LS_AUGROUP', {})

null.setup {
  debug = false,
  sources = {
    b.formatting.stylua.with {
      condition = function(util)
        return util.root_has_file { '.stylua.toml', 'stylua.toml' }
      end,
    },
    b.formatting.rustfmt,
    b.formatting.clang_format.with {
      condition = function(util)
        return util.root_has_file { '.clang-format' }
      end,
    },
    b.formatting.prettier_d_slim.with {
      only_local = './node_modules/.bin/',
    },
  },
  on_attach = function(client, bufnr)
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd [[
    --         augroup LspFormatting
    --             autocmd!
    --             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    --         augroup END
    --         ]]
    -- end
    if client.resolved_capabilities.document_formatting then
      NULL_LS_AUGROUP(function(autocmd, clear)
        clear { buffer = bufnr }

        autocmd({ 'BufWritePre' }, {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.formatting_sync()
          end,
        })
      end)
    end
  end,
}
