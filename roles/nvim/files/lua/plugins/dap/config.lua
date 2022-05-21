local dap = require 'dap'
local dapui = require 'dapui'
local keymap = require 'utils.keymap'
local augroup = require 'utils.augroup'

keymap.set('n', '<leader>m', function()
  local session = dap.session()
  -- session:request('readMemory', {
  --   memoryReference = '',
  --   offset = 0,
  --   count = 1024,
  -- }, function(err, res)
  --   P('response', res)
  --   P('error', err)
  -- end)
end)

dapui.setup {
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = 'scopes',
        size = 0.25, -- Can be float or integer > 1
      },
      { id = 'breakpoints', size = 0.25 },
      { id = 'stacks', size = 0.25 },
      { id = 'watches', size = 00.25 },
    },
    size = 50,
    position = 'left', -- Can be "left", "right", "top", "bottom"
  },

  tray = {
    elements = { 'repl' },
    size = 10,
    position = 'bottom', -- Can be "left", "right", "top", "bottom"
  },

  mappings = {
    expand = { '<tab>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
  },
}

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

dap.adapters.lldb = {
  name = 'lldb',
  command = '/usr/bin/lldb-vscode',
  type = 'executable',
}

dap.configurations.c = {
  {
    name = 'Launch `lldb`',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.loop.cwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {
      'istanze/input/in_1.txt',
      'test.txt',
    },

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}

dap.configurations.gas = dap.configurations.c


augroup('DAP_USER_AUGROUP', {})(function(au)
  au.create({'Filetype'}, {
    pattern = 'dap-repl',
    callback = function(match)
      require('dap.ext.autocompl').attach(match.buf)
    end
  })
end)
