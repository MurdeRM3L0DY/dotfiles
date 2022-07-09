local dap = require 'dap'
local dapui = require 'dapui'

dapui.setup {

  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
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
