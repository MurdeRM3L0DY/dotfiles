return {
  {
    'mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'solidity-ls',
        'solidity',
        'solang',
        'vscode-solidity-server',
        'nomicfoundation-solidity-language-server',
      })
    end,
  },
  {
    'nvim-lspconfig',
    ft = { 'solidity' },
    opts = {
      servers = {
        -- solc = {},
        -- solidity_ls = {},
        -- solidity_ls_nomicfoundation = {},
        -- solang = {},
        solidity = {},
      },
    },
  },
}
