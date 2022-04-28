local fn = vim.fn
local uv = vim.loop

local augroup = require 'utils.augroup'
local MINIMAL_PACKER_AUGROUP = augroup('MINIMAL_PACKER_AUGROUP', {})

local PACKER_DIR = fn.stdpath 'data' .. '/site/pack/packer/'
local START_DIR = PACKER_DIR .. 'start/'
local PACKER_ROOT = START_DIR .. 'packer.nvim'
local packer, packer_setup, load_plugins

local packer_clone = function()
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

  load_plugins()
end

load_plugins = function()
  packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- use {
    --   'noib3/nvim-compleet',
    --   config = "require 'plugins.compleet.config'",
    --   run = 'cargo build && ./install.sh',
    -- }


  use { 'hrsh7th/cmp-cmdline', after = { 'cmp' } }

    use {
      'hrsh7th/nvim-cmp',
      as = 'cmp',
      config = "require 'plugins.cmp.config'",
    }
  end)

  vim.schedule(function()
    if _G.packer_plugins then
      packer.clean()
    end

    packer.install()
  end)
end

local bootstrap = not uv.fs_stat(PACKER_ROOT) and packer_clone or packer_setup
bootstrap()

MINIMAL_PACKER_AUGROUP(function(au)
  au.create('User', {
    pattern = 'PackerComplete',
    callback = function()
      packer.compile()
    end,
  })
end)
