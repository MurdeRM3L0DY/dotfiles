local lazy = require 'utils.lazy'
local keymap = require 'utils.keymap'

---@module 'dap'
local dap = lazy.require 'dap'

---@module 'dapui'
local dapui = lazy.require 'dapui'

keymap.set('n', '<F10>', function()
  dap.continue()
end)

keymap.set('n', '<F6>', function()
  dap.toggle_breakpoint()
end)

keymap.set('n', '<F11>', function()
  dap.step_over()
end)

keymap.set('n', '<leader>dh', function()
  dapui.eval()
end)

keymap.set('n', '<F12>', function()
  dapui.toggle()
end)
