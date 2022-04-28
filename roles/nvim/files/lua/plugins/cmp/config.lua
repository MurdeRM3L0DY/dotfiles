local cmp = require 'cmp'
local codicons = require 'codicons'
local symbols = require('codicons.extensions.completion_item_kind').symbols

cmp.setup {
  -- enabled = false,

  experimental = {
    ghost_text = true,
  },

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  window = {
    completion = {
      border = 'single',
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine',
    },
    documentation = {
      border = 'single',
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine',
    },
  },

  mapping = {
    ['<C-e>'] = cmp.mapping(cmp.config.disable, { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-y>'] = cmp.mapping(cmp.mapping.confirm { select = true }, { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(
      cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      { 'i', 'c' }
    ),
    ['<C-n>'] = cmp.mapping(
      cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      { 'i', 'c' }
    ),
    ['<C-Space>'] = cmp.mapping(function(fallback)
      local complete = not cmp.visible() and cmp.mapping.complete() or cmp.mapping.close()

      complete(fallback)
    end, { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      local complete_or_next = not cmp.visible() and cmp.mapping.complete()
        or cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }

      complete_or_next(fallback)
    end, { 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      local complete_or_prev = not cmp.visible() and cmp.mapping.complete()
        or cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }

      complete_or_prev(fallback)
    end, { 'c' }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 20 },
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer', keyword_length = 2, max_item_count = 10 },
    { name = 'path' },
    { name = 'neorg' },
  }),

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.menu = ({
        ['nvim_lsp'] = '[LSP]',
        ['nvim_lsp_signature_help'] = '[SHELP]',
        ['buffer'] = '[BUF]',
        ['neorg'] = '[NORG]',
        ['path'] = '[PATH]',
      })[entry.source.name]

      vim_item.kind = codicons.get(symbols[vim_item.kind].icon)

      return vim_item
    end,
  },
}

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'cmdline' },
  }, {
    { name = 'path' },
  }),
})
