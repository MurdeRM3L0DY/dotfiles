local HOME = os.getenv 'HOME'

local PLUGINS_HOME = ('%s/dev/plugins'):format(HOME)

return function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'rktjmp/lush.nvim', module = { 'lush' } }

  use {
    ('%s/colorblind.nvim'):format(PLUGINS_HOME),
    branch = 'positioning',
    config = [[vim.api.nvim_command 'colorscheme colorblind']],
  }

  use {
    ('%s/nvim-compleet'):format(PLUGINS_HOME),
    config = [[require 'plugins.compleet.config']],
  }
end
