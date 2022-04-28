local fn = vim.fn
local uv = vim.loop

local augroup = require 'utils.augroup'
local PACKER_USER_AUGROUP = augroup('PACKER_USER_AUGROUP', {})

local PACKER_DIR = fn.stdpath 'data' .. '/site/pack/packer/'
local START_DIR = PACKER_DIR .. 'start/'
local PACKER_ROOT = START_DIR .. 'packer.nvim'

local packer, packer_clone, packer_setup

packer_clone = function()
  local stderr = uv.new_pipe(false)

  uv.spawn('git', {
    stdio = { nil, nil, stderr },
    args = {
      'clone',
      'https://github.com/wbthomason/packer.nvim',
      PACKER_ROOT,
      '--progress',
      '--depth',
      '1',
    },
  }, function(code, signal)
    local success = code == 0 and signal == 0

    if success then
      vim.schedule(function()
        packer_setup()
      end)
    end
  end)

  stderr:read_start(function(err, data)
    if data then
      print(data)
    end
  end)
end

packer_setup = function()
  packer = require 'packer'

  packer.init {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'single' }
      end,
    },
  }

  packer.startup(require 'plugins.spec')
  -- packer.startup(require 'utils.minimal_init')

  vim.schedule(function()
    if _G.packer_plugins then
      packer.clean()
    end
    packer.install()
  end)
end

local bootstrap = not uv.fs_stat(PACKER_ROOT) and packer_clone or packer_setup
bootstrap()

PACKER_USER_AUGROUP(function(au)
  au.create('User', {
    pattern = 'PackerComplete',
    callback = function()
      packer.compile()
    end,
  })
end)
