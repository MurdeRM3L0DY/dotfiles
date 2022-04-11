local K = require 'utils.keymap'

for _, mode in ipairs { 'n', 'o' } do
  K.set(mode, 'm', function()
    require('tsht').nodes()
  end)
end
