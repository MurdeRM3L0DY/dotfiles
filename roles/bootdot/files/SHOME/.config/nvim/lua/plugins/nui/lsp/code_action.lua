local Menu = require 'nui.menu'
local event = require('nui.utils.autocmd').event
local lsp = vim.lsp
local buf = lsp.buf
local request_all = lsp.buf_request_all
local util = lsp.util
local api = vim.api

local width, height = 0, 0

local check_col = function(win, params)
  return 0
end
local check_row = function(win, params)
  return 1
end

---LSP Code Action
---@param context table
local function lsp_code_action(context)
  local bufnr = vim.api.nvim_get_current_buf()
  local win = api.nvim_get_current_win()
  local pos_params = util.make_position_params()
  local code_action_params = util.make_range_params()
  local method = 'textDocument/codeAction'
  context = context or { diagnostics = lsp.diagnostic.get_line_diagnostics() }
  code_action_params.context = context

  request_all(bufnr, method, code_action_params, function(results)
    local actions = {}
    P(results)
    for _, r in pairs(results) do
      vim.list_extend(actions, r.result or {})
    end

    if actions == nil or vim.tbl_isempty(actions) then
      print 'No code actions available'
      return
    end

    local lines = {}
    height = #actions

    for i, action in ipairs(actions) do
      local title = (action.title:gsub('\r\n', '\\r\\n')):gsub('\n', '\\n')
      table.insert(lines, Menu.item(('%d. %s'):format(i, title)))
      width = math.max(width, #title)
    end

    local menu = Menu({
      border = {
        style = 'rounded',
        text = {
          top = '[Code Actions]',
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
          row = pos_params.position.line,
          col = pos_params.position.character,
        },
      },
      -- position the popup window on the line below identifier
      position = {
        row = check_row(win, pos_params),
        col = check_col(win, pos_params),
      },
      size = {
        width = width,
        height = height,
      },
    }, {
      lines = lines,
      keymap = {
        focus_next = { 'j' },
        focus_prev = { 'k' },
        close = { '<esc>' },
        submit = { 'o' },
      },
      on_close = function() end,
      on_submit = function(item)
        local action = actions[item._index]

        -- textDocument/codeAction can return either Command[] or CodeAction[].
        -- If it is a CodeAction, it can have either an edit, a command or both.
        -- Edits should be executed first
        if action.edit or type(action.command) == 'table' then
          if action.edit then
            util.apply_workspace_edit(action.edit)
          end
          if type(action.command) == 'table' then
            buf.execute_command(action.command)
          end
        else
          buf.execute_command(action)
        end
      end,
    })

    menu:mount()

    menu:map('n', 'dn', function()
      menu:unmount()
      local next_pos = vim.diagnostic.get_next_pos()
      api.nvim_win_set_cursor(win, { next_pos[1] + 1, next_pos[2] })
      lsp_code_action()
    end, {
      noremap = true,
    })

    menu:map('n', 'dp', function()
      menu:unmount()
      local prev_pos = vim.diagnostic.get_prev_pos()
      api.nvim_win_set_cursor(win, { prev_pos[1] + 1, prev_pos[2] })
      lsp_code_action()
    end, {
      noremap = true,
    })

    menu:on(event.BufLeave, menu.menu_props.on_close, { noremap = true })
  end)
end

return lsp_code_action
