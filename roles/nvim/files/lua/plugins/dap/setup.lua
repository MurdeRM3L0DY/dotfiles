local keymap = require 'utils.keymap'

local dap = function()
  return require 'dap'
end

local dapui = function()
  return require 'dapui'
end

keymap.set('n', '<F10>', function()
  dap().continue()
end)

keymap.set('n', '<F6>', function()
  dap().toggle_breakpoint()
end)

keymap.set('n', '<F11>', function()
  dap().step_over()
end)

keymap.set('n', '<leader>dh', function()
  dapui().eval()
end)

keymap.set('n', '<F12>', function()
  dapui().toggle()
end)
