local utils = require 'utils.util'

local setup_config_factory = function(sc)
  return function(plugin)
    local modname = ('plugins.%s.%s'):format(plugin, sc)
    if utils.ensure_modname(modname) then
      return ("require '%s'"):format(modname)
    end
    return nil
  end
end

local setup = setup_config_factory 'setup'
local config = setup_config_factory 'config'

local __local = function(name)
  return ('%s/git/neovim/plugins/%s'):format(os.getenv 'HOME', name)
end

local telescope_ext = function(ext)
  return ('telescope._extensions.%s'):format(ext)
end

return function(_use)
  local use = function(name, opts)
    opts = opts or {}

    if opts.as then
      opts.setup = setup(opts.as)
      opts.config = config(opts.as)
    end

    _use(vim.tbl_extend('error', { name }, opts))
  end

  use('wbthomason/packer.nvim', {})

  use('lewis6991/impatient.nvim', {})

  use('nvim-lua/plenary.nvim', { module = { 'plenary' } })

  use('tpope/vim-scriptease', {})

  use('nanotee/luv-vimdocs', {})

  use('milisims/nvim-luaref', {})

  use('jbyuki/venn.nvim', { as = 'venn' })

  use('nvim-neo-tree/neo-tree.nvim', {
    as = 'neo-tree',
    branch = 'v2.x',
    module = { 'neo-tree' },
  })

  -- use('beauwilliams/focus.nvim', {
  --   config = function()
  --     require('focus').setup()
  --   end,
  -- })

  use('MunifTanjim/nui.nvim', { module = { 'nui' } })

  use('rcarriga/nvim-notify', { as = 'notify' })

  -- use('sunjon/stylish.nvim', { module = { 'stylish' } })

  use('kyazdani42/nvim-web-devicons', { module = { 'nvim-web-devicons' } })

  use('yamatsum/nvim-nonicons', { after = { 'nvim-web-devicons' } })

  use('mortepau/codicons.nvim', { module = { 'codicons' } })

  use('rktjmp/shipwright.nvim', { module = { 'shipwright' } })

  use('rktjmp/lush.nvim', { module = { 'lush' } })

  use(__local 'colorblind.nvim', {
    config = [[vim.api.nvim_command 'colorscheme colorblind']],
  })

  -- use(__local 'rust_lua', {
  --   as = 'rust_lua',
  -- })

  -- 'noib3/nvim-compleet',
  use(__local 'nvim-compleet', {
    as = 'compleet',
    run = './install.sh release',
  })

  use('rebelot/heirline.nvim', { as = 'heirline' })

  use('tami5/sqlite.lua', { module = { 'sqlite' } })

  use('romgrk/fzy-lua-native', {
    run = 'make',
    module = { 'fzy-lua-native' },
  })

  use('willthbill/opener.nvim', {
    as = 'opener',
    module = { telescope_ext 'opener' },
  })

  use('folke/lua-dev.nvim', { module = { 'lua-dev' } })

  use('nvim-telescope/telescope.nvim', {
    as = 'telescope',
    module = { 'telescope' },
  })

  use('nvim-telescope/telescope-fzf-native.nvim', {
    module = { 'fzf_lib', telescope_ext 'fzf' },
    run = 'make',
  })

  use('nvim-telescope/telescope-file-browser.nvim', {
    module = { telescope_ext 'file_browser' },
  })

  use('ibhagwan/fzf-lua', { as = 'fzf-lua' })

  use('iamcco/markdown-preview.nvim', {
    run = 'cd app && yarn install',
    ft = { 'markdown' },
  })

  use('lervag/vimtex', { ft = { 'tex' } })

  use('kyazdani42/nvim-tree.lua', {
    as = 'nvim-tree',
    module = { 'nvim-tree' },
  })

  use('ZhiyuanLck/smart-pairs', { as = 'pairs' })

  -- use(__local 'nvim-cmp', { as = 'cmp' })
  use('hrsh7th/nvim-cmp', { as = 'cmp' })
  use('hrsh7th/cmp-nvim-lsp', { after = { 'cmp' }, module = { 'cmp_nvim_lsp' } })
  use('hrsh7th/cmp-nvim-lsp-signature-help', { after = { 'cmp' } })
  use('hrsh7th/cmp-path', { after = { 'cmp' } })
  use('hrsh7th/cmp-cmdline', { after = { 'cmp' } })
  use('hrsh7th/cmp-buffer', { after = { 'cmp' } })

  use('L3MON4D3/LuaSnip', {
    as = 'luasnip',
    module = { 'luasnip' },
  })

  use('neovim/nvim-lspconfig', { as = 'lspconfig' })

  use('williamboman/nvim-lsp-installer', {
    module = { 'nvim-lsp-installer' },
  })

  use('j-hui/fidget.nvim', { as = 'fidget' })

  use('jose-elias-alvarez/null-ls.nvim', { as = 'null-ls' })

  use('jose-elias-alvarez/typescript.nvim', { module = { 'typescript' } })

  use('p00f/clangd_extensions.nvim', { module = 'clangd_extensions' })

  use('simrat39/rust-tools.nvim', { module = 'rust-tools' })

  use('mfussenegger/nvim-jdtls', {
    as = 'jdtls',
    ft = { 'java' },
  })

  use('mfussenegger/nvim-dap', {
    as = 'dap',
    module = { 'dap' },
  })

  use('rcarriga/nvim-dap-ui', { module = { 'dapui' } })

  use('b0o/SchemaStore.nvim', { module = { 'schemastore' } })

  use('folke/trouble.nvim', {
    as = 'trouble',
    module = { 'trouble' },
  })

  use('mfussenegger/nvim-treehopper', {
    as = 'treehopper',
    module = { 'tsht' },
  })

  use('ziontee113/syntax-tree-surfer', {
    as = 'treesurfer',
    module = { 'syntax-tree-surfer' },
  })

  use('nvim-treesitter/nvim-treesitter', { as = 'treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/playground', { after = { 'treesitter' } })
  use('nvim-treesitter/nvim-treesitter-textobjects', { after = { 'treesitter' } })
  use('RRethy/nvim-treesitter-textsubjects', { after = { 'treesitter' } })
  use('JoosepAlviste/nvim-ts-context-commentstring', { after = { 'treesitter' } })
  use('p00f/nvim-ts-rainbow', { after = { 'treesitter' } })

  use('nvim-neorg/neorg', { as = 'neorg' })

  use('akinsho/nvim-bufferline.lua', { as = 'bufferline' })

  use('akinsho/toggleterm.nvim', {
    as = 'toggleterm',
  })

  use('numToStr/Comment.nvim', { as = 'Comment' })

  use('lewis6991/gitsigns.nvim', { as = 'gitsigns' })

  use('TimUntersberger/neogit', {
    as = 'neogit',
    cmd = { 'Neogit' },
  })

  use('sindrets/diffview.nvim', { as = 'diffview', cmd = { 'DiffviewOpen' } })

  use('andymass/vim-matchup', { as = 'matchup' })

  use('wellle/targets.vim', {})

  use('mg979/vim-visual-multi', {})

  use('machakann/vim-sandwich', {})
end
