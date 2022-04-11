local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'

npairs.setup {
  check_ts = true,
  map_cr = true,
  map_bs = true,
  enable_check_bracket_line = true,
}

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return pair == '{}'
    end)
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return context == '{  }'
    end),
}
