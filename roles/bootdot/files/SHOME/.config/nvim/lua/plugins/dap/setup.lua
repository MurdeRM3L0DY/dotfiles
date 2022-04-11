local uv = vim.loop
local K = require 'utils.keymap'

K.set('n', '<F10>', function()
  require('dap').continue()
end)

K.set('n', '<F6>', function()
  require('dap').toggle_breakpoint()
end)

K.set('n', '<F11>', function()
  require('dap').step_over()
end)

K.set('n', '<leader>dh', function()
  require('dapui').eval()
end)

K.set('n', '<F12>', function()
  require('dapui').toggle()
end)

vim.cmd [[
  augroup dap
    au!
    au FileType dap-repl lua require('dap.ext.autocompl').attach()
  augroup end
]]
