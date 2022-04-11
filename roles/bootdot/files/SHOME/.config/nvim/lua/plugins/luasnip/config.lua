local ls = require 'luasnip'
local types = require 'luasnip.util.types'

local load_snippets = function(ft, opts)
  local snippets = require(('plugins.luasnip.snippets.%s'):format(ft))
  ls.add_snippets(ft, snippets, opts or {})
end

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

load_snippets 'lua'
load_snippets 'tex'
