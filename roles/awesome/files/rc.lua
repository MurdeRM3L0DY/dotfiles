-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

local awful = require 'awful'

require 'awful.autofocus'

local beautiful = require 'beautiful'

local CONFIG_DIR = require('gears.filesystem').get_configuration_dir()
beautiful.init(CONFIG_DIR .. 'theme.lua')

awful.spawn.with_shell(CONFIG_DIR .. 'config/autostart.sh')

_G.super = 'Mod4'
_G.ctrl = 'Control'
_G.shift = 'Shift'
_G.alt = 'Mod1'

require 'config.naughty'
require 'config.ui'
require 'config.screen'
require 'config.client'
require 'config.ruled'
require 'config.keybindings'
require 'config.mousebindings'

collectgarbage('setpause', 160)
collectgarbage('setstepmul', 400)
