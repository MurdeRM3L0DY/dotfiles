local heirline = require 'heirline'
local heir_utils = require 'heirline.utils'

local augroup = require 'utils.augroup'
local settings = require 'utils.settings'
local colorblind = require 'colorblind.theme'
local palette = colorblind.Colorblind.lush

local HEIRLINE_AUGROUP = augroup('HEIRLINE_AUGROUP', {})

local sep = {
  vertical_bar = '┃',
  vertical_bar_thin = '│',
  left = '',
  right = '',
  block = '█',
  block_thin = '▌',
  left_filled = '',
  right_filled = '',
  slant_left = '',
  slant_right = '',
  slant_left_thin = '',
  slant_right_thin = '',
  slant_left_2 = '',
  slant_right_2 = '',
  slant_left_2_thin = '',
  slant_right_2_thin = '',
  left_rounded = '',
  right_rounded = '',
  left_rounded_thin = '',
  right_rounded_thin = '',
  circle = '●',
}

local get_icon = function(file_name, file_ext)
  local icon, color = require('nvim-web-devicons').get_icon_color(
    file_name,
    file_ext,
    { default = false }
  )
  return icon, color
end

local Align = {
  provider = '%=',
}

local Space = setmetatable({
  provider = ' ',
}, {
  __call = function(_, count)
    return {
      provider = (' '):rep(count),
    }
  end,
})

local ViMode = {
  {
    hl = function(self)
      return {
        fg = self.mode_map[self.mode].hl.bg,
      }
    end,
    provider = sep.left_rounded,
  },
  {
    hl = function(self)
      return self.mode_map[self.mode].hl
    end,
    provider = function(self)
      return self.mode_map[self.mode].text
    end,
  },
  {
    hl = function(self)
      return {
        fg = self.mode_map[self.mode].hl.bg,
      }
    end,
    provider = sep.right_rounded,
  },
}

local Git = {
  {
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
    provider = sep.left_rounded,
  },

  {
    hl = {
      bg = palette.catppuccin.black2.hex,
    },

    {
      condition = function(self)
        self.status = vim.b.gitsigns_status_dict
        return self.status ~= nil
      end,

      {
        condition = function(self)
          return self.status.head ~= ''
        end,

        {
          hl = {
            fg = palette.catppuccin.gray1.hex,
          },
          provider = function(self)
            return self.status.head
          end,
        },
        {
          condition = function(self)
            return self.status.added ~= nil
              or self.status.changed ~= nil
              or self.status.removed ~= nil
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.status.added ~= nil
        end,

        {
          {
            hl = heir_utils.get_highlight 'GitSignsAdd',
            provider = function(self)
              return '+' .. self.status.added
            end,
          },
          Space,
        },
      },
      {
        condition = function(self)
          return self.status.changed ~= nil
        end,
        {
          {
            hl = heir_utils.get_highlight 'GitSignsChange',
            provider = function(self)
              return '~' .. self.status.changed
            end,
          },
          Space,
        },
      },
      {
        condition = function(self)
          return self.status.removed ~= nil
        end,
        hl = heir_utils.get_highlight 'GitSignsDelete',
        provider = function(self)
          return '-' .. self.status.removed
        end,
      },
    },
  },

  {
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
    provider = sep.right_rounded,
  },
}

local Diagnostics = {
  {
    provider = sep.left_rounded,
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
  },

  {
    hl = {
      bg = palette.catppuccin.black2.hex,
    },

    {
      condition = function(self)
        self.diagnostics = vim.diagnostic.get(0)
        return #self.diagnostics > 0
      end,
      init = function(self)
        self.severity = vim.diagnostic.severity
        local count = { 0, 0, 0, 0 }
        for _, diagnostic in ipairs(self.diagnostics) do
          count[diagnostic.severity] = count[diagnostic.severity] + 1
        end

        self.info = count[vim.diagnostic.severity.INFO]
        self.hint = count[vim.diagnostic.severity.HINT]
        self.warn = count[vim.diagnostic.severity.WARN]
        self.error = count[vim.diagnostic.severity.ERROR]
      end,
      static = {
        DiagnosticSignHint = settings.ui.signs.Hint,
        DiagnosticSignInfo = settings.ui.signs.Info,
        DiagnosticSignWarn = settings.ui.signs.Warn,
        DiagnosticSignError = settings.ui.signs.Error,
      },

      {
        condition = function(self)
          return self.error > 0
        end,

        {
          hl = heir_utils.get_highlight 'DiagnosticSignError',
          provider = function(self)
            return self.DiagnosticSignError .. self.error
          end,
        },
        {
          condition = function(self)
            return self.warn > 0 or self.info > 0 or self.hint > 0
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.warn > 0
        end,

        {
          hl = heir_utils.get_highlight 'DiagnosticSignWarn',
          provider = function(self)
            return self.DiagnosticSignWarn .. self.warn
          end,
        },
        {
          condition = function(self)
            return self.info > 0 or self.hint > 0
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.info > 0
        end,

        {
          hl = heir_utils.get_highlight 'DiagnosticSignInfo',
          provider = function(self)
            return self.DiagnosticSignInfo .. self.info
          end,
        },
        {
          condition = function(self)
            return self.hint > 0
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.hint > 0
        end,
        hl = heir_utils.get_highlight 'DiagnosticSignhint',
        provider = function(self)
          return self.DiagnosticSignHint .. self.hint
        end,
      },
    },
  },

  {
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
    provider = sep.right_rounded,
  },
}

local Workspace = {
  {
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
    provider = sep.left_rounded,
  },

  {
    init = function(self)
      if self.cwd == '/' then
        self.cwd = ''
      end
    end,
    hl = {
      bg = palette.catppuccin.black2.hex,
    },

    {
      hl = {
        fg = palette.colorblind.flickeryc64.hex,
      },
      provider = function(self)
        return vim.fn.fnamemodify(self.cwd .. '/', ':~')
      end,
    },
    {
      {
        condition = function(self)
          return self.rel_path ~= '' and vim.bo.buftype == ''
        end,
        hl = function(self)
          return {
            fg = self.icon_color,
          }
        end,

        {
          provider = function(self)
            return self.rel_path
          end,
        },
        {
          condition = function(_)
            return not vim.bo.readonly
          end,

          { provider = '[' },
          {
            hl = {
              fg = palette.catppuccin.gray1.hex,
              bg = palette.catppuccin.black2.hex,
            },
            provider = function(_)
              return vim.bo.modified and '+'
            end,
          },
          { provider = ']' },
        },
      },

      {
        condition = function()
          return vim.bo.filetype == 'toggleterm'
        end,
        provider = function()
          return require('toggleterm.terminal').get(vim.b.toggle_number).name
        end,
      },
    },
  },
  {
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
    provider = sep.right_rounded,
  },
}

local FileType = {
  {
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
    provider = sep.left_rounded,
  },
  {
    hl = function(self)
      return {
        fg = self.icon_color,
        bg = palette.catppuccin.black2.hex,
      }
    end,
    provider = function(_)
      return vim.bo.filetype
    end,
  },
  {
    condition = function(self)
      return self.file_icon ~= nil
    end,
    hl = function(self)
      return {
        fg = self.icon_color,
        bg = palette.catppuccin.black2.hex,
      }
    end,

    Space,
    {
      provider = function(self)
        return self.file_icon
      end,
    },
    Space,
  },
  {
    provider = sep.right_rounded,
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
  },
}

local Location = {
  {
    provider = sep.left_rounded,
    hl = function(self)
      return {
        fg = self.mode_map[self.mode].hl.bg,
      }
    end,
  },
  {
    provider = '%03l:%02v',
    hl = function(self)
      return self.mode_map[self.mode].hl
    end,
  },
  {
    provider = sep.right_rounded,
    hl = function(self)
      return {
        fg = self.mode_map[self.mode].hl.bg,
      }
    end,
  },
}

local StatusLine = {
  init = function(self)
    self.cwd = vim.loop.cwd()
    self.mode = vim.api.nvim_get_mode().mode
    self.full_path = vim.fn.expand '%'
    self.rel_path = self.full_path:gsub(self.cwd .. '/', '')
    self.file_icon, self.icon_color = get_icon(self.full_path, vim.fn.expand '%:e')
  end,
  static = {
    mode_map = {
      ['n'] = {
        text = 'NORMAL',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.blue.hex },
      },
      ['no'] = { text = 'O-PENDING', hl = { fg = '', bg = '' } },
      ['nov'] = { text = 'O-PENDING', hl = { fg = '', bg = '' } },
      ['noV'] = { text = 'O-PENDING', hl = { fg = '', bg = '' } },
      ['no'] = { text = 'O-PENDING', hl = { fg = '', bg = '' } },
      ['niI'] = { text = 'I-NORMAL', hl = { fg = '', bg = '' } },
      ['niR'] = { text = 'R-NORMAL', hl = { fg = '', bg = '' } },
      ['niV'] = { text = 'VR-NORMAL', hl = { fg = '', bg = '' } },
      ['nt'] = {
        text = 'T-NORMAL',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.colorblind.infraredgloze.hex },
      },
      ['v'] = {
        text = 'VISUAL',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['vs'] = {
        text = 'V-SELECT',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['V'] = {
        text = 'V-LINE',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['Vs'] = {
        text = 'VL-SELECT',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.mauve.hex },
      },
      [''] = {
        text = 'V-BLOCK',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['s'] = {
        text = 'VB-SELECT',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['s'] = { text = 'SELECT', hl = { fg = '', bg = '' } },
      ['S'] = { text = 'S-LINE', hl = { fg = '', bg = '' } },
      [''] = { text = 'S-BLOCK', hl = { fg = '', bg = '' } },
      ['i'] = {
        text = 'INSERT',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.lavender.hex },
      },
      ['ic'] = {
        text = 'INSERT',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.lavender.hex },
      },
      ['ix'] = {
        text = 'INSERT',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.lavender.hex },
      },
      ['R'] = { text = 'REPLACE', hl = { fg = '', bg = '' } },
      ['Rc'] = { text = 'REPLACE', hl = { fg = '', bg = '' } },
      ['Rv'] = { text = 'V-REPLACE', hl = { fg = '', bg = '' } },
      ['Rx'] = { text = 'REPLACE', hl = { fg = '', bg = '' } },
      ['Rvc'] = { text = 'V-REPLACE', hl = { fg = '', bg = '' } },
      ['Rvx'] = { text = 'V-REPLACE', hl = { fg = '', bg = '' } },
      ['c'] = {
        text = 'COMMAND',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.red.hex },
      },
      ['cv'] = { text = 'EX', hl = { fg = '', bg = '' } },
      ['ce'] = { text = 'EX', hl = { fg = '', bg = '' } },
      ['r'] = { text = 'HIT-ENTER', hl = { fg = '', bg = '' } },
      ['rm'] = { text = 'MORE', hl = { fg = '', bg = '' } },
      ['r?'] = { text = 'CONFIRM', hl = { fg = '', bg = '' } },
      ['!'] = { text = 'SHELL', hl = { fg = '', bg = '' } },
      ['t'] = {
        text = 'TERMINAL',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.colorblind.infraredgloze.hex },
      },
    },
  },
  hl = {
    bold = true,
    italic = true,
  },

  {
    ViMode,
    Space,
    Git,
    Space,
    Diagnostics,
    Space,
    Workspace,
    Align,
    FileType,
    Space,
    Location,
  },
}

HEIRLINE_AUGROUP(function(au)
  au.create({ 'ColorScheme' }, {
    callback = function()
      heirline.reset_highlights()
    end,
  })
end)

heirline.setup(StatusLine)
