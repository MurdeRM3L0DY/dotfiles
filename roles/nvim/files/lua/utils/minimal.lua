local fn = vim.fn
local uv = vim.loop
local HOME = os.getenv 'HOME'

local PACKER_DIR = fn.stdpath 'data' .. '/site/pack/packer/'
local START_DIR = PACKER_DIR .. 'start/'
local OPT_DIR = PACKER_DIR .. '/opt'
local PACKER_ROOT = START_DIR .. 'packer.nvim'
local PLUGINS_HOME = ('%s/dev/plugins'):format(HOME)


local augroup = function(group, augroup_opts)
  local id = vim.api.nvim_create_augroup(
    group,
    vim.tbl_extend('force', { clear = true }, augroup_opts or {})
  )

  return function(callback)
    callback(function(event, autocmd_opts)
      autocmd_opts.group = id
      vim.api.nvim_create_autocmd(event, autocmd_opts)
    end)
  end
end

local PACKER_USER_AUGROUP = augroup 'PACKER_USER_AUGROUP'

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


  use { 'rktjmp/lush.nvim', module = { 'lush' } }

  use {
    ('%s/colorblind.nvim'):format(PLUGINS_HOME),
    config = [[vim.api.nvim_command 'colorscheme colorblind']],
  }

    use {
      ('%s/nvim-compleet'):format(PLUGINS_HOME),
      config = [[require 'plugins.compleet.config']],
    }
  end)

  if _G.packer_plugins then
    vim.schedule(function()
      packer.clean()
    end)
  end

  packer.install()
end

local bootstrap = not uv.fs_stat(PACKER_ROOT) and packer_clone or packer_setup
bootstrap()

PACKER_USER_AUGROUP(function(autocmd)
  autocmd('User', {
    pattern = 'PackerComplete',
    callback = function()
      packer.compile()
    end,
  })
end)
