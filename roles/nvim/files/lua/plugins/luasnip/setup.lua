local K = require 'utils.keymap'

local luasnip = function()
  return require 'luasnip'
end

local luasnip_jump = function(dir)
  if luasnip().jumpable(dir) then
    luasnip().jump(dir)
  end
end

local luasnip_change_choice = function(dir)
  if luasnip().choice_active() then
    luasnip().change_choice(dir)
  end
end

K.key('<C-j>', {
  i = {
    rhs = function()
      if luasnip().expand_or_jumpable() then
        luasnip().expand_or_jump()
      end
    end,
    opts = {
      desc = 'expand node or jump to next node'
    }
  },
  s = function()
    luasnip_jump(1)
  end,
})

K.set({ 'i', 's' }, '<C-k>', function()
  luasnip_jump(-1)
end)

K.set({ 'i', 's' }, '<C-e>', function()
  luasnip_change_choice(1)
end)
