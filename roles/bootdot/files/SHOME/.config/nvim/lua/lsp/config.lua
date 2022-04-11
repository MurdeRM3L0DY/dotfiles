local M = {}
local K = require 'utils.keymap'
local augroup = require 'utils.augroup'
local LSP_AUGROUP = augroup 'LSP_AUGROUP'

local cfg = {}

local mappings = function(client, bufnr)
  local opts = { buffer = bufnr }

  K.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, opts)
  K.set('n', '<leader>rn', function()
    vim.lsp.buf.rename()
  end, opts)
  K.set('n', 'gD', function()
    vim.lsp.buf.declaration()
  end, opts)
  K.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)
  K.set('n', 'K', function()
    vim.lsp.buf.hover()
  end, opts)
  K.set('n', 'gi', function()
    vim.lsp.buf.implementation()
  end, opts)
  K.set('i', '<C-s>', function()
    local params = vim.lsp.util.make_position_params()
    client.request('textDocument/signatureHelp', params, function(err, res, _, _)
      P(res)
    end)
    vim.lsp.buf.signature_help()
  end, opts)
  K.set('n', 'gt', function()
    vim.lsp.buf.type_definition()
  end, opts)
  K.set('n', 'gr', function()
    require('telescope.builtin').lsp_references {
      layout_strategy = 'center',
    }
  end, opts)
  K.set('n', '<leader>ss', function()
    require('telescope.builtin').lsp_document_symbols {
      layout_strategy = 'vertical',
    }
  end, opts)
  K.set('n', '<leader>F', function()
    vim.lsp.buf.formatting()
  end, opts)

  K.set('n', '<leader>dd', function()
    vim.diagnostic.open_float()
  end, opts)
  K.set('n', '<leader>dk', function()
    vim.diagnostic.goto_prev()
  end, opts)
  K.set('n', '<leader>dj', function()
    vim.diagnostic.goto_next()
  end, opts)
  K.set('n', '<leader>dl', function()
    vim.diagnostic.setloclist()
  end, opts)

  -- K.set('i', '<C-s>', function()
  --   vim.lsp.buf.signature_help()
  -- end, opts)
  --
  -- K('n', {
  --   K.key('K', function()
  --     vim.lsp.buf.hover()
  --   end, { desc = 'LSP: hover' }),
  --
  --   K.key('<leader>', {
  --     K.key('ca', function()
  --       vim.lsp.buf.code_action()
  --     end, { desc = 'LSP: code action' }),
  --
  --     K.key('rn', function()
  --       vim.lsp.buf.rename()
  --     end, { desc = 'LSP: rename' }),
  --
  --     K.key('F', function()
  --       vim.lsp.buf.formatting()
  --     end, { desc = 'LSP: formatting' }),
  --
  --     -- diagnostics
  --     K.key('d', {
  --       K.key('d', function()
  --         vim.diagnostic.open_float()
  --       end, { desc = 'DIAGNOSTIC: open float' }),
  --       K.key('j', function()
  --         vim.diagnostic.goto_next()
  --       end, { desc = 'DIAGNOSTIC: goto next' }),
  --       K.key('k', function()
  --         vim.diagnostic.goto_prev()
  --       end, { desc = 'DIAGNOSTIC: goto prev' }),
  --       K.key('l', function()
  --         vim.diagnostic.setloclist()
  --       end, { desc = 'DIAGNOSTIC: set loclist' }),
  --     }),
  --
  --     K.key('ss', function()
  --       require('telescope.builtin').lsp_document_symbols {
  --         layout_strategy = 'vertical',
  --       }
  --     end),
  --   }),
  --
  --   K.key('g', {
  --     K.key('d', function()
  --       vim.lsp.buf.definition()
  --     end, { desc = 'LSP: goto definition' }),
  --     K.key('D', function()
  --       vim.lsp.buf.declaration()
  --     end, { desc = 'LSP: goto declaration' }),
  --     K.key('r', function()
  --       require('telescope.builtin').lsp_references {
  --         layout_strategy = 'center',
  --       }
  --     end, { desc = 'LSP: find references' }),
  --     K.key('i', function()
  --       vim.lsp.buf.implementation()
  --     end, { desc = 'LSP: goto implementation' }),
  --     K.key('t', function()
  --       vim.lsp.buf.type_definition()
  --     end, { desc = 'LSP: goto type definition' }),
  --   }),
  -- }, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(function()
  return require 'cmp_nvim_lsp'
end)

if has_cmp_nvim_lsp then
  cfg.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

cfg.on_attach = function(client, bufnr)
  -- use null-ls for code formatting
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.range_formatting = false

  -- require('lsp.handlers.documentColor').on_attach(client, bufnr)

  if client.server_capabilities.codeLensProvider then
    LSP_AUGROUP(function(autocmd)
      autocmd({ 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end)
  end

  mappings(client, bufnr)
end

cfg.on_init = function(client, initialize_result)
  vim.notify(('`%s` attached'):format(client.name))
end

M.client_config = function(opts)
  for _, k in ipairs { 'on_attach', 'on_init', 'on_new_config' } do
    opts[k] = (function(o)
      return function(...)
        local _ = cfg[k] and cfg[k](...)
        local _ = o and o(...)
      end
    end)(opts[k])
  end

  for _, k in ipairs { 'handlers', 'capabilities' } do
    opts[k] = vim.tbl_extend('keep', cfg[k] or {}, opts[k] or {})
  end

  return opts
end

return M
