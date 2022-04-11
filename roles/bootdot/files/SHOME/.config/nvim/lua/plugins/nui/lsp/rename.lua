local Input = require 'nui.input'

local curr_name = vim.fn.expand '<cword>'
local params = vim.lsp.util.make_position_params()

local input = Input({
  border = {
    style = 'single',
    text = {
      top = '[Rename]',
      top_align = 'left',
    },
  },
  -- highlight for the window.
  highlight = 'Normal:Normal',
  -- place the popup window relative to the
  -- buffer position of the identifier
  relative = {
    type = 'buf',
    position = {
      -- this is the same `params` we got earlier
      row = params.position.line,
      col = params.position.character,
    },
  },
  -- position the popup window on the line below identifier
  position = {
    row = 1,
    col = 0,
  },
  -- 25 cells wide, should be enough for most identifier names
  size = {
    width = 25,
    height = 1,
  },
}, {
  default_value = curr_name,
  prompt = '',
  -- on_submit = function(newName)
  --   if not newName or #newName == 0 or curr_name == newName then
  --     return
  --   end
  --
  --   params.newName = newName
  --
  --   vim.lsp.buf_request(0, "textDocument/rename", params, function(_, result)
  --     P(result)
  --     if not result then
  --       return
  --     end
  --
  --     vim.lsp.util.apply_workspace_edit(result)
  --   end)
  -- end,
})

return function(request)
  return function()
    P(request)
    input.on_submit = function(self, newName)
      P(newName)
    end
    input:mount()
  end
end
