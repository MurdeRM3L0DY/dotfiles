local Menu = require 'nui.menu'
local event = require('nui.utils.autocmd').event
local select_ui = nil

---@diagnostic disable-next-line: unused-local
local unused = 'nil'

return function(items, opts, on_choice)
  if select_ui then
    -- ensure single ui.select operation
    vim.api.nvim_err_writeln 'busy: another select is pending!'
    return
  end

  local function on_done(item, index)
    if select_ui then
      -- if it's still mounted, unmount it
      select_ui:unmount()
    end
    -- P(item, index)
    -- pass the select value
    on_choice(item, index)
    -- indicate the operation is done
    select_ui = nil
  end

  local prompt = opts.prompt or '[Choose Item]'
  local kind = opts.kind or 'unknown'
  local format_item = (function(f)
    f = f or tostring
    local count = 0

    return function(item)
      count = count + 1
      return ('%s: %s'):format(count, f(item))
    end
  end)(opts.format_item)

  local relative = 'editor'
  local position = '50%'

  if kind == 'codeaction' then
    -- change position for codeaction selection
    relative = 'cursor'
    position = {
      row = 1,
      col = 0,
    }
  end

  local max_width = vim.api.nvim_win_get_width(0)

  local lines = {}
  for _, item in ipairs(items) do
    local item_text = format_item(item):sub(0, max_width - 2)
    lines[#lines + 1] = Menu.item(item_text, item)
  end

  select_ui = Menu({
    relative = relative,
    position = position,
    border = {
      style = 'single',
      highlight = 'FloatBorder',
      text = {
        top = prompt,
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal',
    },
  }, {
    lines = lines,
    on_close = function()
      on_done(nil, nil)
    end,
    on_submit = function(item)
      on_done(item, nil)
    end,
  })

  select_ui:mount()

  -- cancel operation if cursor leaves select
  select_ui:on(event.BufLeave, function()
    on_done(nil, nil)
  end, { once = true })
end
