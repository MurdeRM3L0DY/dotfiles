local keymap = require 'utils.keymap'
local utils = require 'utils.util'
local make_config = require('lsp.config').make_config

require('nvim-lsp-installer').setup {
  ensure_installed = { 'jdtls' },
  automatic_installation = {
    exclude = { 'clangd', 'rust_analyzer' },
  },
}

local lspconfig = require 'lspconfig'

local lspconfig_setup = function(server, opts)
  if opts == nil then
    local modname = ('plugins.lspconfig.configs.%s'):format(server)
    if utils.ensure_modname(modname) then
      opts = require(modname)
    end
  end

  lspconfig[server].setup(make_config(opts or {}))
end

lspconfig_setup 'sumneko_lua'
lspconfig_setup 'tsserver'
lspconfig_setup 'arduino_language_server'
lspconfig_setup 'cssls'
lspconfig_setup 'tailwindcss'
lspconfig_setup 'eslint'
lspconfig_setup 'pyright'
lspconfig_setup 'gopls'
lspconfig_setup 'texlab'
lspconfig_setup 'jsonls'
lspconfig_setup 'yamlls'
lspconfig_setup 'ansiblels'

require('clangd_extensions').setup {
  server = make_config {
    cmd = {
      'clangd',
      '--suggest-missing-includes',
      '--header-insertion=iwyu',
    },
    capabilities = {
      offsetEncoding = { 'utf-16' },
    },
  },
  extensions = {
    -- defaults:
    -- Automatically set inlay hints (type hints)
    autoSetHints = true,
    -- Whether to show hover actions inside the hover window
    -- This overrides the default hover handler
    hover_with_actions = true,
    -- These apply to the default ClangdSetInlayHints command
    inlay_hints = {
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause  higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = 'CursorHold',
      -- whether to show parameter hints with the inlay hints or not
      show_parameter_hints = true,
      -- prefix for parameter hints
      parameter_hints_prefix = '<- ',
      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = '=> ',
      -- whether to align to the length of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = 'Comment',
    },
    ast = {
      role_icons = {
        type = '',
        declaration = '',
        expression = '',
        specifier = '',
        statement = '',
        ['template argument'] = '',
      },

      kind_icons = {
        Compound = '',
        Recovery = '',
        TranslationUnit = '',
        PackExpansion = '',
        TemplateTypeParm = '',
        TemplateTemplateParm = '',
        TemplateParamObject = '',
      },

      highlights = {
        detail = 'Comment',
      },
      memory_usage = {
        border = 'none',
      },
      symbol_info = {
        border = 'none',
      },
    },
  },
}

require('rust-tools').setup {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,

    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = '<- ',
      -- Only show inlay hints for the current line
      -- only_current_line = true,

      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause  higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      -- only_current_line_autocmd = 'CursorMoved,TextChangedI,TextChangedP',

      other_hints_prefix = ': ',
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
    },

    hover_actions = {
      border = 'single',
    },
  },
  server = make_config {},
}

local typescript = require 'typescript'
typescript.setup {
  disable_commands = false, -- prevent the plugin from creating Vim commands
  disable_formatting = false, -- disable tsserver's formatting capabilities
  debug = false, -- enable debug logging for commands
  server = make_config { -- pass options to lspconfig's setup method
    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr }
      keymap.set('n', '<leader>gs', function()
        typescript.actions.organizeImports()
      end, opts)
      keymap.set('n', '<leader>gq', function()
        typescript.actions.removeUnused()
      end, opts)
      keymap.set('n', '<leader>gi', function()
        typescript.actions.addMissingImports()
      end, opts)
      keymap.set('n', '<leader>gf', function()
        typescript.actions.fixAll()
      end, opts)
    end,
  },
}
