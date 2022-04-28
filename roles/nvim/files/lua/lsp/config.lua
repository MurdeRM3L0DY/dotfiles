local M = {}

local keymap = require 'utils.keymap'
local augroup = require 'utils.augroup'

local LSP_AUGROUP = augroup('LSP_AUGROUP', {})

local cfg = {}

local mappings = function(client, bufnr)
  local opts = { buffer = bufnr }

  keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, opts)
  keymap.set('n', '<leader>rn', function()
    vim.lsp.buf.rename()
  end, opts)
  keymap.set('n', 'gD', function()
    vim.lsp.buf.declaration()
  end, opts)
  keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)
  keymap.set('n', 'K', function()
    vim.lsp.buf.hover()
  end, opts)
  keymap.set('n', 'gi', function()
    vim.lsp.buf.implementation()
  end, opts)
  keymap.set('i', '<C-s>', function()
    vim.lsp.buf.signature_help()
  end, opts)
  keymap.set('n', 'gt', function()
    vim.lsp.buf.type_definition()
  end, opts)
  keymap.set('n', 'gr', function()
    require('telescope.builtin').lsp_references {
      layout_strategy = 'center',
    }
  end, opts)
  keymap.set('n', '<leader>ss', function()
    require('telescope.builtin').lsp_document_symbols {
      layout_strategy = 'vertical',
    }
  end, opts)

  keymap.set('n', '<leader>dd', function()
    vim.diagnostic.open_float()
  end, opts)
  keymap.set('n', '<leader>dk', function()
    vim.diagnostic.goto_prev()
  end, opts)
  keymap.set('n', '<leader>dj', function()
    vim.diagnostic.goto_next()
  end, opts)
  keymap.set('n', '<leader>dl', function()
    vim.diagnostic.setloclist()
  end, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(function()
  return require 'cmp_nvim_lsp'
end)

if has_cmp_nvim_lsp then
  cfg.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

cfg.on_init = function(client, _)
  vim.notify(('`%s` initialized'):format(client.name))
end

cfg.on_attach = function(client, bufnr)
  -- use null-ls for code formatting
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- require('lsp.handlers.documentColor').on_attach(client, bufnr)

  if client.server_capabilities.codeLensProvider then
    LSP_AUGROUP(function(au)
      au.create({ 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end)
  end

  mappings(client, bufnr)
end

M.make_config = function(opts)
  for _, k in ipairs { 'on_init', 'on_attach' } do
    opts[k] = (function(o)
      return function(...)
        local _ = cfg[k] and cfg[k](...)
        local _ = o and o(...)
      end
    end)(opts[k])
  end

  for _, k in ipairs { 'capabilities' } do
    opts[k] = vim.tbl_extend('keep', cfg[k] or {}, opts[k] or {})
  end

  return opts
end

return M
