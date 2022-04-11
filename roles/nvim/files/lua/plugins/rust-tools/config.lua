require('rust-tools').setup {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,

    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = '<- ',
      -- Only show inlay hints for the current line
      -- only_current_line = true,

      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause  higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      -- only_current_line_autocmd = 'CursorMoved,TextChangedI,TextChangedP',

      other_hints_prefix = ': ',
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
    },

    hover_actions = {
      border = 'single',
    },
  },
  server = require('lsp.config').client_config {},
}
