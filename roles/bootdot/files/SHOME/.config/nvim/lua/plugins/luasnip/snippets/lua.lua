local ls = require 'luasnip'
local snip = ls.snippet
local t = ls.text_node

return {
  snip({ trig = 'text' }, { t { 'simple text' } }, {}),
}
