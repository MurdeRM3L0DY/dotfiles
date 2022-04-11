local cmp = require 'cmp'
local codicons = require 'codicons'
local symbols = require('codicons.extensions.completion_item_kind').symbols

cmp.setup {
  enabled = true,
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  documentation = {
    border = { '', '', '', '│', '', '', '', '│' },
    winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
  },
  mapping = {
    ['<C-e>'] = cmp.config.disable,
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-y>'] = cmp.mapping(cmp.mapping.confirm { select = true }, { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(function(fallback)
      local complete = not cmp.visible() and cmp.mapping.complete() or cmp.mapping.close()
      complete(fallback)
    end, { 'i', 'c' }),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = codicons.get(symbols[vim_item.kind].icon)

      vim_item.menu = ({
        ['nvim_lsp'] = '[LSP]',
        ['nvim_lsp_signature_help'] = '[SHELP]',
        ['buffer'] = '[BUF]',
        ['luasnip'] = '[SNIP]',
        ['neorg'] = '[NORG]',
        ['path'] = '[PATH]',
      })[entry.source.name]

      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer', keyword_length = 1 },
    { name = 'neorg' },
  }, {
    { name = 'path' },
  }),
}

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources {
    { name = 'cmdline' },
    { name = 'path' },
  },
})
