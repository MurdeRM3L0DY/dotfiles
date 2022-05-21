local augroup = require 'utils.augroup'
local settings = require 'utils.settings'

local heirline = require 'heirline'
local colorblind = require 'colorblind.theme'

local palette = colorblind.Colorblind.lush

augroup('HEIRLINE_AUGROUP', {})(function(au)
  au.create({ 'ColorScheme' }, {
    callback = function()
      heirline.reset_highlights()
    end,
  })
end)

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
  left_rounded = '',
  right_rounded = '',
  left_rounded_thin = '',
  right_rounded_thin = '',
  circle = '●',
}

local StatusLine = {
  init = function(self)
    self.stlmode = vim.api.nvim_get_mode().mode
  end,
  hl = {
    bold = true,
    italic = true,
  },
  static = {
    stlmodemap = {
      ['n'] = {
        text = 'NORMAL',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.blue.hex },
      },
      ['no'] = {
        text = 'O-PENDING',
        hl = { fg = '', bg = '' },
      },
      ['nov'] = {
        text = 'O-PENDING',
        hl = { fg = '', bg = '' },
      },
      ['noV'] = {
        text = 'O-PENDING',
        hl = { fg = '', bg = '' },
      },
      ['no'] = {
        text = 'O-PENDING',
        hl = { fg = '', bg = '' },
      },
      ['niI'] = {
        text = 'I-NORMAL',
        hl = { fg = '', bg = '' },
      },
      ['niR'] = {
        text = 'R-NORMAL',
        hl = { fg = '', bg = '' },
      },
      ['niV'] = {
        text = 'VR-NORMAL',
        hl = { fg = '', bg = '' },
      },
      ['nt'] = {
        text = 'T-NORMAL',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.red.hex },
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
      ['s'] = {
        text = 'SELECT',
        hl = { fg = '', bg = '' },
      },
      ['S'] = {
        text = 'S-LINE',
        hl = { fg = '', bg = '' },
      },
      [''] = {
        text = 'S-BLOCK',
        hl = { fg = '', bg = '' },
      },
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
      ['R'] = {
        text = 'REPLACE',
        hl = { fg = '', bg = '' },
      },
      ['Rc'] = {
        text = 'REPLACE',
        hl = { fg = '', bg = '' },
      },
      ['Rv'] = {
        text = 'V-REPLACE',
        hl = { fg = '', bg = '' },
      },
      ['Rx'] = {
        text = 'REPLACE',
        hl = { fg = '', bg = '' },
      },
      ['Rvc'] = {
        text = 'V-REPLACE',
        hl = { fg = '', bg = '' },
      },
      ['Rvx'] = {
        text = 'V-REPLACE',
        hl = { fg = '', bg = '' },
      },
      ['c'] = {
        text = 'COMMAND',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.colorblind.red.hex },
      },
      ['cv'] = {
        text = 'EX',
        hl = { fg = '', bg = '' },
      },
      ['ce'] = {
        text = 'EX',
        hl = { fg = '', bg = '' },
      },
      ['r'] = {
        text = 'HIT-ENTER',
        hl = { fg = '', bg = '' },
      },
      ['rm'] = {
        text = 'MORE',
        hl = { fg = '', bg = '' },
      },
      ['r?'] = {
        text = 'CONFIRM',
        hl = { fg = '', bg = '' },
      },
      ['!'] = {
        text = 'SHELL',
        hl = { fg = '', bg = '' },
      },
      ['t'] = {
        text = 'TERMINAL',
        hl = { fg = palette.catppuccin.black2.hex, bg = palette.catppuccin.red.hex },
      },
    },
  },
}

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
        fg = self.stlmodemap[self.stlmode].hl.bg,
      }
    end,
    provider = sep.left_rounded,
  },
  {
    hl = function(self)
      return self.stlmodemap[self.stlmode].hl
    end,
    provider = function(self)
      return self.stlmodemap[self.stlmode].text
    end,
  },
  {
    hl = function(self)
      return {
        fg = self.stlmodemap[self.stlmode].hl.bg,
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
        self.stlgitstatus = vim.b.gitsigns_status_dict
        return self.stlgitstatus ~= nil
      end,

      {
        condition = function(self)
          return self.stlgitstatus.head ~= ''
        end,

        {
          hl = {
            fg = palette.catppuccin.gray1.hex,
          },
          provider = function(self)
            return self.stlgitstatus.head
          end,
        },
        {
          condition = function(self)
            return self.stlgitstatus.added ~= nil
              or self.stlgitstatus.changed ~= nil
              or self.stlgitstatus.removed ~= nil
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.stlgitstatus.added ~= nil
        end,

        {
          hl = {
            fg = colorblind.GitSignsAdd.fg.hex,
          },
          provider = function(self)
            return '+' .. self.stlgitstatus.added
          end,
        },
        Space,
      },
      {
        condition = function(self)
          return self.stlgitstatus.changed ~= nil
        end,

        {
          hl = {
            fg = colorblind.GitSignsChange.fg.hex,
          },
          provider = function(self)
            return '~' .. self.stlgitstatus.changed
          end,
        },
        Space,
      },
      {
        condition = function(self)
          return self.stlgitstatus.removed ~= nil
        end,
        hl = {
          fg = colorblind.GitSignsDelete.fg.hex,
        },
        provider = function(self)
          return '-' .. self.stlgitstatus.removed
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
        self.stldiagnostics = vim.diagnostic.get(0)
        return #self.stldiagnostics > 0
      end,
      init = function(self)
        local count = { 0, 0, 0, 0 }
        for _, diagnostic in ipairs(self.stldiagnostics) do
          count[diagnostic.severity] = count[diagnostic.severity] + 1
        end

        self.stldiagnosticserror = count[vim.diagnostic.severity.ERROR]
        self.stldiagnosticswarn = count[vim.diagnostic.severity.WARN]
        self.stldiagnosticsinfo = count[vim.diagnostic.severity.INFO]
        self.stldiagnosticshint = count[vim.diagnostic.severity.HINT]
      end,

      {
        condition = function(self)
          return self.stldiagnosticserror > 0
        end,

        {
          hl = {
            fg = colorblind.DiagnosticSignError.fg.hex,
          },
          provider = function(self)
            return settings.ui.diagnostics.Error .. self.stldiagnosticserror
          end,
        },
        {
          condition = function(self)
            return self.stldiagnosticswarn > 0
              or self.stldiagnosticsinfo > 0
              or self.stldiagnosticshint > 0
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.stldiagnosticswarn > 0
        end,

        {
          hl = {
            fg = colorblind.DiagnosticSignWarn.fg.hex,
          },
          provider = function(self)
            return settings.ui.diagnostics.Warn .. self.stldiagnosticswarn
          end,
        },
        {
          condition = function(self)
            return self.stldiagnosticsinfo > 0 or self.stldiagnosticshint > 0
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.stldiagnosticsinfo > 0
        end,

        {
          hl = {
            fg = colorblind.DiagnosticSignInfo.fg.hex,
          },
          provider = function(self)
            return settings.ui.diagnostics.Info .. self.stldiagnosticsinfo
          end,
        },
        {
          condition = function(self)
            return self.stldiagnosticshint > 0
          end,

          Space,
        },
      },
      {
        condition = function(self)
          return self.stldiagnosticshint > 0
        end,
        hl = {
          fg = colorblind.DiagnosticSignHint.fg.hex,
        },
        provider = function(self)
          return settings.ui.diagnostics.Hint .. self.stldiagnosticshint
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
      self.stlbuftype = vim.bo.buftype
      self.stlcwd = vim.loop.cwd()
      self.stlbufname = vim.api.nvim_buf_get_name(0)
    end,
    hl = {
      bg = palette.catppuccin.black2.hex,
      fg = palette.catppuccin.gray1.hex,
    },

    {
      condition = function(self)
        return self.stlbuftype == 'terminal'
      end,
      provider = 'term://',
    },
    {
      hl = {
        fg = palette.colorblind.blue.hex,
      },
      provider = function(self)
        return vim.fn.fnamemodify(self.stlcwd, ':~')
      end,
    },

    {
      condition = function(self)
        return self.stlbuftype == ''
      end,
      init = function(self)
        if self.stlcwd == '/' then
          self.stlfilepath = self.stlbufname:sub(2, -1)
        else
          -- doesn't work in certain directories. Not sure why.'
          -- self.stlfilepath = self.stlbufname:gsub(self.stlcwd, '')

          self.stlfilepath = self.stlbufname:sub(#self.stlcwd + 1, -1)
        end
      end,

      {
        provider = function(self)
          return self.stlfilepath
        end,
      },
      {
        condition = function()
          return not vim.bo.readonly
        end,

        { provider = '[' },
        {
          condition = function()
            return vim.bo.modified
          end,
          hl = {
            fg = palette.catppuccin.flamingo.hex,
          },
          provider = '+',
        },
        { provider = ']' },
      },
    },

    {
      condition = function(self)
        return self.stlbuftype == 'terminal'
      end,
      provider = function(self)
        local pattern = '//[%d%p]+' .. vim.o.shell .. '[%p%w]+'
        return self.stlbufname:match(pattern)
      end,
    },

    {
      condition = function(self)
        return self.stlbuftype == 'help'
      end,

      provider = function(self)
        return vim.fn.fnamemodify(self.stlbufname, ':~')
      end,
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
    hl = {
      fg = palette.catppuccin.gray1.hex,
      bg = palette.catppuccin.black2.hex,
    },
    provider = function()
      return vim.bo.filetype
    end,
  },
  {
    hl = {
      fg = palette.catppuccin.black2.hex,
    },
    provider = sep.right_rounded,
  },
}

local Location = {
  {
    hl = function(self)
      return {
        fg = self.stlmodemap[self.stlmode].hl.bg,
      }
    end,
    provider = sep.left_rounded,
  },
  {
    hl = function(self)
      return self.stlmodemap[self.stlmode].hl
    end,
    provider = '%03l:%02v',
  },
  {
    hl = function(self)
      return {
        fg = self.stlmodemap[self.stlmode].hl.bg,
      }
    end,
    provider = sep.right_rounded,
  },
}

table.insert(StatusLine, {
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
})

heirline.setup(StatusLine)
