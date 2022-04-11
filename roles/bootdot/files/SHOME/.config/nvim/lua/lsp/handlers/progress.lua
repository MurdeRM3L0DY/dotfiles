local M = {}

M.loading = {
  animation = {
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏',
  },
  index = 1,
  log = '',
  spinner = '',
  is_running = false,
  fetch = function()
    return M.loading.spinner .. ' ' .. M.loading.log
  end,
  start = function(message)
    M.loading.log = message
    M.loading.is_running = true
    M.loading.update()
  end,
  stop = function()
    M.loading.is_running = false
    M.loading.log = ''
    M.loading.spinner = ''
  end,
  update = function()
    if M.loading.is_running then
      M.loading.spinner = M.loading.animation[M.loading.index]

      M.loading.index = M.loading.index + 1

      if M.loading.index == 10 then
        M.loading.index = 1
      end

      vim.fn.timer_start(50, function()
        M.loading.update()
      end)
    end
  end,
}

local messages = {}
local clients = {}

local last_redraw = nil
local timer_going = false

local update_interval = 50
local function redraw_callback(now)
  last_redraw = now or vim.loop.now()
  vim.api.nvim_command 'redrawstatus!'
  timer_going = false
end

local wrapped_redraw_callback = vim.schedule_wrap(redraw_callback)
local timer = vim.loop.new_timer()
local function redraw()
  local now = vim.loop.now()
  if last_redraw == nil or now - last_redraw >= update_interval then
    timer:stop()
    redraw_callback(now)
  elseif not timer_going then
    timer_going = true
    timer:start(update_interval + last_redraw - now, 0, wrapped_redraw_callback)
  end
end

local function unregister_client(id)
  messages[id] = nil
  clients[id] = nil
end

local function ensure_init(messages, id, name)
  if not messages[id] then
    messages[id] = { name = name, messages = {}, progress = {}, status = {} }
  end
end
local function progress_callback(_, res, ctx)
  local client_id = ctx.client_id

  ensure_init(messages, client_id, client_id)
  local val = res.value
  if val.kind then
    if val.kind == 'begin' then
      messages[client_id].progress[res.token] = {
        title = val.title,
        message = val.message,
        percentage = val.percentage,
        spinner = 1,
      }
    elseif val.kind == 'report' then
      messages[client_id].progress[res.token].message = val.message
      messages[client_id].progress[res.token].percentage = val.percentage
      messages[client_id].progress[res.token].spinner = messages[client_id].progress[res.token].spinner
        + 1
    elseif val.kind == 'end' then
      if messages[client_id].progress[res.token] == nil then
        vim.api.nvim_command 'echohl WarningMsg'
        vim.api.nvim_command(
          'echom "[lsp-status] Received `end` message with no corresponding `begin` from  '
            .. clients[client_id]
            .. '!"'
        )
        vim.api.nvim_command 'echohl None'
      else
        messages[client_id].progress[res.token].message = val.message
        messages[client_id].progress[res.token].done = true
        messages[client_id].progress[res.token].spinner = nil
      end
    end
  else
    table.insert(messages[client_id], { content = val, show_once = true, shown = 0 })
  end

  -- P(messages[client_id])

  redraw()
end

-- Process messages
local function get_messages()
  local new_messages = {}
  local msg_remove = {}
  local progress_remove = {}
  for client, data in pairs(messages) do
    if vim.lsp.client_is_stopped(client) then
      unregister_client(client)
    else
      for token, ctx in pairs(data.progress) do
        table.insert(new_messages, {
          name = data.name,
          title = ctx.title,
          message = ctx.message,
          percentage = ctx.percentage,
          progress = true,
          spinner = ctx.spinner,
        })

        if ctx.done then
          table.insert(progress_remove, { client = client, token = token })
        end
      end

      for i, msg in ipairs(data.messages) do
        if msg.show_once then
          msg.shown = msg.shown + 1
          if msg.shown > 1 then
            table.insert(msg_remove, { client = client, idx = i })
          end
        end

        table.insert(new_messages, { name = data.name, content = msg.content })
      end

      if next(data.status) ~= nil then
        table.insert(new_messages, {
          name = data.name,
          content = data.status.content,
          uri = data.status.uri,
          status = true,
        })
      end
    end
  end

  for _, item in ipairs(msg_remove) do
    table.remove(messages[item.client].messages, item.idx)
  end
  for _, item in ipairs(progress_remove) do
    messages[item.client].progress[item.token] = nil
  end
  return new_messages
end
