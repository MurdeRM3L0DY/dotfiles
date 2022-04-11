local K = require 'utils.keymap'

local luasnip_jump = function(dir)
  if require('luasnip').jumpable(dir) then
    require('luasnip').jump(dir)
  end
end

local luasnip_change_choice = function(dir)
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(dir)
  end
end

K.key('<C-j>', {
  i = function()
    if require('luasnip').expand_or_jumpable() then
      require('luasnip').expand_or_jump()
    end
  end,
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
