return {
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    dependencies = {
      {
        'jmbuhr/otter.nvim',
        dependencies = {
          {
            'nvim-cmp',
            opts = function(_, opts)
              local cmp = require('cmp')
              vim.list_extend(
                opts.sources,
                cmp.config.sources {
                  { name = 'otter' },
                }
              )
            end,
          },
        },
        opts = {},
      },
      {
        'nvim-lspconfig',
        opts = {
          servers = {
            marksman = {},
          },
        },
      },
      { import = 'specs.lang.r' },
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        languages = { 'r', 'python', 'julia', 'bash' },
        chunks = 'curly', -- 'curly' or 'all'
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = 'molten', -- 'molten' or 'slime'
        ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
      },
      keymap = {
        hover = 'K',
        definition = 'gd',
        rename = '<leader>rn',
        references = 'gr',
      },
    },
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '0.1.*',
    build = function()
      require('typst-preview').update()
    end,
  },
  {
    'nvim-lspconfig',
    ft = { 'typst' },
    opts = {
      servers = {
        typst_lsp = {},
      },
    },
  },
  {
    'mason.nvim',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'typst-lsp')
    end,
  },
}
