return {
  'folke/noice.nvim',
  event = 'UIEnter',
  config = function()
    require('noice').setup {
      cmdline = {
        enabled = true,
        view = 'cmdline',
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },

        signature = {
          enabled = false,
          throttle = 0,
        },
        hover = {
          enabled = true,
        },
      },

      views = {
        hover = {
          border = {
            style = 'single',
          },
        },
      },

      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
  end,
}
