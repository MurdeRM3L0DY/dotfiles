local misc = {}

misc.safe = function(v)
  if v == nil or v == vim.NIL then
    return nil
  end
  return v
end

misc.set = function(t, keys, v)
  local c = t
  for i = 1, #keys - 1 do
    local key = keys[i]
    c[key] = misc.safe(c[key]) or {}
    c = c[key]
  end
  c[keys[#keys]] = v
  return c[keys[#keys]]
end

---Generate id for group name
misc.id = setmetatable({
  group = {},
}, {
  __call = function(_, group)
    misc.id.group[group] = misc.id.group[group] or vim.loop.now()
    misc.id.group[group] = misc.id.group[group] + 1
    return misc.id.group[group]
  end,
})

---Create once callback
---@param callback function
---@return function
misc.once = function(callback)
  local done = false
  return function(...)
    if done then
      return
    end
    done = true
    callback(...)
  end
end

return misc
