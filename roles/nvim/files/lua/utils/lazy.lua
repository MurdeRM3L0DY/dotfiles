local lazy = {}

lazy.require_on_index = function(path)
  return setmetatable({}, {
    __index = function(_, key)
      return require(path)[key]
    end,

    __newindex = function(_, key, value)
      require(path)[key] = value
    end,
  })
end

lazy.require_on_module_call = function(path)
  return setmetatable({}, {
    __call = function(_, ...)
      return require(path)(...)
    end,
  })
end

lazy.require_on_exported_call = function(path)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...)
        return require(path)[k](...)
      end
    end,
  })
end

return lazy
