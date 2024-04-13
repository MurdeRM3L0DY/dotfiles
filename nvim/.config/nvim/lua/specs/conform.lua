return {
  {
    'stevearc/conform.nvim',
    keys = function()
      local function format(opts, cb)
        require('conform').format(opts, cb)
      end

      -- override default lsp format keymap
      require('config.lsp').update_keys {
        {
          '<leader>F',
          function()
            format({ lsp_fallback = true }, nil)
          end,
          mode = { 'n', 'v' },
        },
      }

      return {
        {
          '<leader>F',
          function()
            format({}, nil)
          end,
          mode = { 'n', 'v' },
        },
      }
    end,

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
      formatters_by_ft = {},
      formatters = {},
    },
  },
}
