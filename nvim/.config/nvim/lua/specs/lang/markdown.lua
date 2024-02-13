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
    ft = { 'markdown', 'quarto' },
    dependencies = {
      { 'jmbuhr/otter.nvim' },
      {
        'nvim-lspconfig',
        opts = {
          servers = {
            marksman = {},
            r_language_server = {},
          },
        },
      },
      {
        'mason.nvim',
        opts = function(_, opts)
          table.insert(opts.ensure_installed, 'r-languageserver')
          table.insert(opts.ensure_installed, 'marksman')
        end,
      },
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
        enabled = false,
        default_method = nil, -- 'molten' or 'slime'
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
}
