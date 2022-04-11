local ft = require 'Comment.ft'

require('Comment').setup {
  mappings = {
    -- operator-pending mapping
    -- Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
    -- NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    -- extra mapping
    -- Includes `gco`, `gcO`, `gcA`
    extra = true,
    -- extended mapping
    -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },
  ---@param ctx Ctx
  pre_hook = function(ctx)
    -- Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == 'typescriptreact' then
      local U = require 'Comment.utils'

      -- Detemine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring {
        key = type,
        location = location,
      }
    end
  end,
}

ft.set('blif', '#%s')
