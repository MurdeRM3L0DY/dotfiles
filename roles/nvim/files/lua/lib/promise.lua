-- adapted from 'nvim-lsp-installer' async module
local co = coroutine

local async, await

---@class Promise
---@field resolver fun(resolve: fun(...), reject: fun(...))
local Promise = {}
Promise.__index = Promise

---@private
local function table_pack(...)
  return { n = select('#', ...), ... }
end

---@private
---@param success boolean
---@param cb fun(success: boolean, ...)
local _wrap_resolver_cb = function(promise, success, cb)
  return function(...)
    if promise.has_resolved then
      return
    end
    promise.has_resolved = true
    cb(success, { ... })
  end
end

function Promise.new(resolver)
  return setmetatable({ resolver = resolver, has_resolved = false }, Promise)
end

function Promise:__call(callback)
  self.resolver(_wrap_resolver_cb(self, true, callback), _wrap_resolver_cb(self, false, callback))
end

-- local Failure = {}
--

async = function(fn, callback, ...)
  local thread = co.create(function()
    fn(await)
  end)
  local cancelled = false
  local step

  step = function(...)
    if cancelled then
      return
    end

    local ok, promise_or_result = co.resume(thread, ...)
    if ok then
      if getmetatable(promise_or_result) == Promise then
        promise_or_result(step)
      else
        callback(true, promise_or_result)
        thread = nil
      end
    else
      callback(false, promise_or_result)
      thread = nil
    end
  end

  step(...)

  return function()
    cancelled = true
    thread = nil
  end
end

await = function(resolver)
  local ok, res_or_err = co.yield(Promise.new(resolver))
  if not ok then
    return res_or_err[1], nil
  end
  return nil, unpack(res_or_err)
end

local promisify = function(async_fn)
  return function(...)
    local args = table_pack(...)
    return await(function(resolve, reject)
      args[args.n + 1] = resolve
      local ok, err = pcall(async_fn, unpack(args, 1, args.n + 1))
      if not ok then
        reject(err)
      end
    end)
  end
end

local sleep = function(ms)
  await(function(resolve, _)
    vim.defer_fn(resolve, ms)
  end)
end

local scheduler = function()
  await(vim.schedule)
end

return {
  async = async,
  await = await,
  sleep = sleep,
  scheduler = scheduler,
  promisify = promisify,
}
