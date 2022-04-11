local HOME = vim.loop.os_homedir()

local setup = function(plugin)
  return ("require 'plugins.%s.setup'"):format(plugin)
end

local config = function(plugin)
  return ("require 'plugins.%s.config'"):format(plugin)
end

local telescope_ext = function(ext)
  return ('telescope._extensions.%s'):format(ext)
end

local fork = function(name)
  return ('%s/dev/plugins/%s'):format(HOME, name)
end

return function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'lewis6991/impatient.nvim' }

  use { 'nvim-lua/plenary.nvim', module = { 'plenary' } }

  use { 'tpope/vim-scriptease' }

  use { 'nanotee/luv-vimdocs' }

  use { 'milisims/nvim-luaref' }

  use { 'jbyuki/venn.nvim', config = config 'venn' }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    module = { 'neo-tree' },
    setup = setup 'neo-tree',
    config = config 'neo-tree',
  }

  use {
    'beauwilliams/focus.nvim',
    config = function()
      require('focus').setup()
    end,
    disable = true,
  }

  use { 'MunifTanjim/nui.nvim', config = config 'nui' }

  use { 'rcarriga/nvim-notify', config = config 'notify' }

  use {
    'sunjon/stylish.nvim',
    module = { 'stylish' },
  }

  use { 'kyazdani42/nvim-web-devicons', module = { 'nvim-web-devicons' } }

  use { 'yamatsum/nvim-nonicons', after = { 'nvim-web-devicons' } }

  use { 'mortepau/codicons.nvim', module = { 'codicons' } }

  use { 'rktjmp/lush.nvim', module = { 'lush' } }

  use {
    ('%s/dev/plugins/colorblind.nvim'):format(HOME),
    config = [[vim.api.nvim_command 'colorscheme colorblind']],
  }

  use {
    ('%s/dev/plugins/rust_lua'):format(HOME),
    config = config 'rust_lua',
  }

  use {
    fork 'nvim-compleet',
    config = config 'compleet',
    -- run = 'cargo build --release && make install',
    -- branch = 'back2rpc',
    run = 'cargo build --release && make install',
    commit = '08cd076',
    -- disable = true,
  }

  use { 'rebelot/heirline.nvim', config = config 'heirline' }

  use { 'tami5/sqlite.lua', module = { 'sqlite' } }

  use { 'nvim-lualine/lualine.nvim', config = config 'lualine', disable = true }

  use { 'romgrk/fzy-lua-native', run = 'make', module = { 'fzy-lua-native' } }

  use {
    'willthbill/opener.nvim',
    module = { telescope_ext 'opener' },
    config = config 'opener',
  }

  -- use { 'junegunn/fzf.vim', requires = { 'junegunn/fzf' } }

  use { 'folke/lua-dev.nvim', module = { 'lua-dev' } }

  use {
    'nvim-telescope/telescope.nvim',
    module = { 'telescope' },
    setup = setup 'telescope',
    config = config 'telescope',
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    module = { 'fzf_lib', telescope_ext 'fzf' },
    run = 'make',
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    module = { telescope_ext 'file_browser' },
  }

  use {
    'nvim-telescope/telescope-frecency.nvim',
    module = { telescope_ext 'frecency' },
  }

  use { 'ibhagwan/fzf-lua', config = config 'fzf-lua', module = { 'fzf-lua' } }

  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = { 'markdown' },
  }

  use { 'lervag/vimtex', ft = { 'tex' } }

  use {
    'kyazdani42/nvim-tree.lua',
    module = { 'nvim-tree' },
    setup = setup 'nvim-tree',
    config = config 'nvim-tree',
  }

  use { 'hrsh7th/nvim-cmp', config = config 'cmp' }
  use { 'hrsh7th/cmp-nvim-lsp', module = { 'cmp_nvim_lsp' }, after = { 'nvim-cmp' } }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = { 'nvim-cmp' } }
  use { 'hrsh7th/cmp-path', after = { 'nvim-cmp' } }
  use { 'hrsh7th/cmp-cmdline', after = { 'nvim-cmp' } }
  use { 'hrsh7th/cmp-buffer', after = { 'nvim-cmp' } }
  use { 'saadparwaiz1/cmp_luasnip', after = { 'nvim-cmp' } }

  use {
    'L3MON4D3/LuaSnip',
    module = { 'luasnip' },
    config = config 'luasnip',
    setup = setup 'luasnip',
  }

  use { 'neovim/nvim-lspconfig', config = config 'lspconfig' }

  use { 'williamboman/nvim-lsp-installer', module = { 'nvim-lsp-installer' } }

  use { 'j-hui/fidget.nvim', config = config 'fidget' }

  use { 'jose-elias-alvarez/null-ls.nvim', config = config 'null-ls' }

  use { 'jose-elias-alvarez/nvim-lsp-ts-utils', module = { 'nvim-lsp-ts-utils' } }

  use {
    'mfussenegger/nvim-dap',
    setup = setup 'dap',
    config = config 'dap',
    module = { 'dap' },
  }

  use { 'rcarriga/nvim-dap-ui', module = { 'dapui' } }

  use { 'b0o/SchemaStore.nvim', module = { 'schemastore' } }

  use { 'michaelb/sniprun', run = './install.sh' }

  use {
    'folke/trouble.nvim',
    module = { 'trouble' },
    setup = setup 'trouble',
    config = config 'trouble',
  }

  use {
    'mfussenegger/nvim-jdtls',
    config = config 'jdtls',
    ft = { 'java' },
  }

  use {
    'p00f/clangd_extensions.nvim',
    config = config 'clangd_extensions',
    ft = { 'c', 'cpp' },
  }

  use {
    'simrat39/rust-tools.nvim',
    config = config 'rust-tools',
    ft = { 'rust' },
  }

  use {
    'mfussenegger/nvim-treehopper',
    module = { 'tsht' },
    setup = setup 'tsht',
  }

  use { 'nvim-treesitter/nvim-treesitter', config = config 'treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground', after = { 'nvim-treesitter' } }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }
  use { 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', after = { 'nvim-treesitter' } }
  use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' } }

  use { 'nvim-neorg/neorg', config = config 'neorg' }

  use { 'akinsho/nvim-bufferline.lua', config = config 'bufferline' }

  use { 'akinsho/toggleterm.nvim', config = config 'toggleterm', keys = { [[<C-\>]] } }

  use { 'numToStr/Comment.nvim', config = config 'Comment' }

  -- use {
  --   'windwp/nvim-autopairs',
  --   config = config 'autopairs',
  --   event = { 'InsertEnter *' },
  -- }

  use { 'lewis6991/gitsigns.nvim', config = config 'gitsigns' }

  use { 'pwntester/octo.nvim', config = config 'octo' }

  use {
    'TimUntersberger/neogit',
    config = config 'neogit',
    cmd = { 'Neogit' },
  }

  use { 'sindrets/diffview.nvim', config = config 'diffview', cmd = { 'DiffviewOpen' } }

  use { 'andymass/vim-matchup', config = config 'matchup' }

  use { 'wellle/targets.vim' }

  use { 'mg979/vim-visual-multi', keys = { { 'n', '<C-n>' } } }

  use { 'machakann/vim-sandwich' }

  use { 'dstein64/vim-startuptime' }
end
