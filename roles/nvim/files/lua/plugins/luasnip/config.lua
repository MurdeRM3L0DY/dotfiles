local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.setup {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged,TextChangedI',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '', 'Identifier' } },
      },
    },
  },
}

require('luasnip.loaders.from_lua').lazy_load {
  paths = '~/.config/nvim/lua/plugins/luasnip/snippets',
}
