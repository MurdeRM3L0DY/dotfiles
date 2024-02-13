local USER_AUGROUP = require('config.autocmds')

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- lazy = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = true,
            },
          },
          navic = true,
          neogit = true,
          neotree = true,
          semantic_tokens = true,
          mason = true,
          barbar = true,
          markdown = true,
          octo = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = true,
          noice = true,
          flash = true,
          lsp_trouble = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
        -- compile_path = '',
        highlight_overrides = {},
      }

      vim.cmd.colorschem('catppuccin')
    end,
  },
  {
    'rktjmp/lush.nvim',
    lazy = false,
    init = function(p)
      USER_AUGROUP(function(au)
        au.create('User', {
          pattern = 'Flavours',
          callback = function()
            require('lazy').reload { plugins = { p } }
          end,
          once = true,
        })
      end)
    end,
    config = function()
      vim.cmd.colorscheme('lush')
    end,
  },
  -- {
  --   'echasnovski/mini.colors',
  --   config = function()
  --     require('mini.colors').setup {}
  --   end,
  -- },
  -- {
  --   'echasnovski/mini.hues',
  --   -- lazy = false,
  --   opts = function()
  --     local palette = require('utils.palette')
  --     return {
  --       background = palette.BASE00.da(20).hex,
  --       foreground = palette.BASE05.sa(20).hex,
  --       saturation = 'medium',
  --       n_hues = 8,
  --     }
  --   end,
  -- },
}
