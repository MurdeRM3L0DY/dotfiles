-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------

local GLib = require('lgi').GLib
local gobject = require('gears.object')
local gtable = require('gears.table')
local subscribable = require('module.animation.subscribable')
local tween = require('module.animation.tween')
local ipairs = ipairs
local table = table
local pairs = pairs

local animation_manager = {}
animation_manager.easing = {
  linear = 'linear',
  inQuad = 'inQuad',
  outQuad = 'outQuad',
  inOutQuad = 'inOutQuad',
  outInQuad = 'outInQuad',
  inCubic = 'inCubic',
  outCubic = 'outCubic',
  inOutCubic = 'inOutCubic',
  outInCubic = 'outInCubic',
  inQuart = 'inQuart',
  outQuart = 'outQuart',
  inOutQuart = 'inOutQuart',
  outInQuart = 'outInQuart',
  inQuint = 'inQuint',
  outQuint = 'outQuint',
  inOutQuint = 'inOutQuint',
  outInQuint = 'outInQuint',
  inSine = 'inSine',
  outSine = 'outSine',
  inOutSine = 'inOutSine',
  outInSine = 'outInSine',
  inExpo = 'inExpo',
  outExpo = 'outExpo',
  inOutExpo = 'inOutExpo',
  outInExpo = 'outInExpo',
  inCirc = 'inCirc',
  outCirc = 'outCirc',
  inOutCirc = 'inOutCirc',
  outInCirc = 'outInCirc',
  inElastic = 'inElastic',
  outElastic = 'outElastic',
  inOutElastic = 'inOutElastic',
  outInElastic = 'outInElastic',
  inBack = 'inBack',
  outBack = 'outBack',
  inOutBack = 'inOutBack',
  outInBack = 'outInBack',
  inBounce = 'inBounce',
  outBounce = 'outBounce',
  inOutBounce = 'inOutBounce',
  outInBounce = 'outInBounce',
}

local animation = {}

local instance = nil

local ANIMATION_FRAME_DELAY = 5

local function micro_to_milli(micro)
  return micro / 1000
end

local function second_to_micro(sec)
  return sec * 1000000
end

local function second_to_milli(sec)
  return sec * 1000
end

function animation:start(args)
  if self.state == false then
    args = args or {}

    -- Awestore/Rubato compatibility
    -- I'd rather this always be a table, but Awestore/Rubato
    -- expect the :set() method to have 1 number value parameter
    -- used to set the target
    local is_table = type(args) == 'table'
    local initial = is_table and (args.pos or self.pos) or self.pos
    local subject = is_table and (args.subject or self.subject) or self.subject
    local target = is_table and (args.target or self.target) or args
    local duration = is_table and (args.duration or self.duration) or self.duration
    local easing = is_table and (args.easing or self.easing) or self.easing

    duration = self._private.anim_manager._private.instant == true and 0.01 or duration

    if self.tween == nil or self.reset_on_stop == true then
      self.tween = tween.new {
        initial = initial,
        subject = subject,
        target = target,
        duration = second_to_micro(duration),
        easing = easing,
      }
    end

    if self._private.anim_manager._private.animations[self.index] == nil then
      table.insert(self._private.anim_manager._private.animations, self)
    end

    self.state = true
    self.last_elapsed = GLib.get_monotonic_time()

    self.started:fire()
    self:emit_signal('started')
  end
end

function animation:set(args)
  self:start(args)
  self:emit_signal('set')
end

function animation:stop()
  if self.state == true then
    self.state = false
    self:emit_signal('stopped')
  end
end

function animation:abort()
  animation:stop()
  self:emit_signal('aborted')
end

function animation:initial()
  return self._private.initial
end

function animation_manager:set_instant(value)
  self._private.instant = value
end

function animation_manager:new(args)
  args = args or {}

  args.pos = args.pos or 0
  args.subject = args.subject or nil
  args.target = args.target or nil
  args.duration = args.duration or 0
  args.easing = args.easing or nil
  args.loop = args.loop or false
  args.signals = args.signals or {}
  args.update = args.update or nil
  args.reset_on_stop = args.reset_on_stop == nil and true or args.reset_on_stop

  -- Awestore/Rubato compatibility
  local ret = subscribable()
  ret.state = false
  ret.started = subscribable()
  ret.ended = subscribable()
  if args.subscribed ~= nil then
    ret:subscribe(args.subscribed)
  end

  for signal, cb in pairs(args.signals) do
    ret:connect_signal(signal, cb)
  end
  if args.update ~= nil then
    ret:connect_signal('update', args.update)
  end

  gtable.crush(ret, args, true)
  gtable.crush(ret, animation, true)

  ret._private = {}
  ret._private.anim_manager = self
  ret._private.initial = args.pos

  return ret
end

local function new()
  local ret = gobject {}
  gtable.crush(ret, animation_manager, true)

  ret._private = {}
  ret._private.animations = {}
  ret._private.instant = false

  GLib.timeout_add(GLib.PRIORITY_DEFAULT, ANIMATION_FRAME_DELAY, function()
    for index, anim in ipairs(ret._private.animations) do
      if anim.state == true then
        -- compute delta time
        local time = GLib.get_monotonic_time()
        local delta = time - anim.last_elapsed
        anim.last_elapsed = time

        -- If pos is true, the animation has ended
        local pos = anim.tween:update(delta)
        if pos == true then
          -- Loop the animation, don't end it.
          -- Useful for widgets like the spinning cicle
          if anim.loop == true then
            anim.tween:reset()
          else
            -- Snap to end
            anim.pos = anim.tween.target
            anim:fire(anim.pos)
            anim:emit_signal('update', anim.pos)

            anim.state = false
            anim.ended:fire(pos)
            table.remove(ret._private.animations, index)
            anim:emit_signal('ended', anim.pos)
          end
          -- Animation in process, keep updating
        else
          anim.pos = pos
          anim:fire(anim.pos)
          anim:emit_signal('update', anim.pos)
        end
      else
        table.remove(ret._private.animations, index)
      end
    end

    -- call again the function after cooldown
    return true
  end)

  return ret
end

if not instance then
  instance = new()
end
return instance
