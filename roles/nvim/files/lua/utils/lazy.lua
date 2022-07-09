local lazy = {}

lazy.require = function(modname)
  return setmetatable({}, {
    __call = function(_, ...)
      return require(modname)(...)
    end,
    __index = function(_, k)
      return rawget(require(modname), k)
    end,
    __newindex = function(_, k, v)
      rawset(require(modname), k, v)
    end,
  })
end

return lazy
