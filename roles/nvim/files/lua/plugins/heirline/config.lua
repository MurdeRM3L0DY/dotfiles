local augroup = require 'utils.augroup'
local settings = require 'utils.settings'

local heirline = require 'heirline'
local heir_conds = require 'heirline.conditions'
local heir_utils = require 'heirline.utils'
local colorblind = require 'colorblind.theme'

local palette = colorblind.Colorblind.lush

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

local vim = _G.vim
local string = _G.string

local api = vim.api
local bo = vim.bo

local str_find = string.find
local str_sub = string.sub
local str_match = string.match
local str_rep = string.rep

local nvim_get_mode = api.nvim_get_mode
local nvim_buf_get_name = api.nvim_buf_get_name
local get_diagnostic = vim.diagnostic.get
local fnamemodify = vim.fn.fnamemodify
local cwd = vim.loop.cwd

augroup('HEIRLINE_AUGROUP', {})(function(au)
  au.create({ 'ColorScheme' }, {
    callback = function()
      heirline.reset_highlights()
    end,
  })
end)

local setup_workspace = function(self)
  self.stlbufname = nvim_buf_get_name(0)
  self.stlbuftype = bo.buftype
  self.stlcwd = cwd()
end

local StatusLine = {
  init = function(self)
    self.stlmode = nvim_get_mode().mode
  end,
  hl = {
    bold = true,
    italic = true,
  },
  static = {
    stlmodemap = {
      ['n'] = {
        text = 'NORMAL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['no'] = {
        text = 'O-PENDING',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['nov'] = {
        text = 'O-PENDING',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['noV'] = {
        text = 'O-PENDING',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['no'] = {
        text = 'O-PENDING',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['niI'] = {
        text = 'I-NORMAL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['niR'] = {
        text = 'R-NORMAL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['niV'] = {
        text = 'VR-NORMAL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['nt'] = {
        text = 'T-NORMAL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.blue.hex },
      },
      ['v'] = {
        text = 'VISUAL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['vs'] = {
        text = 'V-SELECT',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['V'] = {
        text = 'V-LINE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['Vs'] = {
        text = 'VL-SELECT',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.mauve.hex },
      },
      [''] = {
        text = 'V-BLOCK',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['s'] = {
        text = 'VB-SELECT',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.mauve.hex },
      },
      ['s'] = {
        text = 'SELECT',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.lavender.hex },
      },
      ['S'] = {
        text = 'S-LINE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.lavender.hex },
      },
      [''] = {
        text = 'S-BLOCK',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.lavender.hex },
      },
      ['i'] = {
        text = 'INSERT',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.green.hex },
      },
      ['ic'] = {
        text = 'INSERT',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.green.hex },
      },
      ['ix'] = {
        text = 'INSERT',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.green.hex },
      },
      ['R'] = {
        text = 'REPLACE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.red.hex },
      },
      ['Rc'] = {
        text = 'REPLACE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.red.hex },
      },
      ['Rv'] = {
        text = 'V-REPLACE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.red.hex },
      },
      ['Rx'] = {
        text = 'REPLACE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.red.hex },
      },
      ['Rvc'] = {
        text = 'V-REPLACE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.red.hex },
      },
      ['Rvx'] = {
        text = 'V-REPLACE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.red.hex },
      },
      ['c'] = {
        text = 'COMMAND',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.peach.hex },
      },
      ['cv'] = {
        text = 'EX',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.peach.hex },
      },
      ['ce'] = {
        text = 'EX',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.catppuccin.peach.hex },
      },
      ['r'] = {
        text = 'HIT-ENTER',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.colorblind.blue.hex },
      },
      ['rm'] = {
        text = 'MORE',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.colorblind.blue.hex },
      },
      ['r?'] = {
        text = 'CONFIRM',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.colorblind.blue.hex },
      },
      ['!'] = {
        text = 'SHELL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.colorblind.red.hex },
      },
      ['t'] = {
        text = 'TERMINAL',
        hl = { fg = palette.catppuccin.base.hex, bg = palette.colorblind.red.hex },
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
      provider = str_rep(' ', count),
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
    -- update = { 'ModeChanged' },
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
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.left_rounded,
  },

  {
    hl = {
      bg = palette.catppuccin.base.hex,
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
            fg = palette.catppuccin.subtext0.hex,
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
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.right_rounded,
  },
}

local Diagnostics = {
  update = { 'DiagnosticChanged' },
  {
    hl = {
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.left_rounded,
  },

  {
    hl = {
      bg = palette.catppuccin.base.hex,
    },

    {
      condition = function(self)
        self.stldiagnostics = get_diagnostic(0)
        return #self.stldiagnostics > 0
      end,
      init = function(self)
        local count = { 0, 0, 0, 0 }
        for _, diagnostic in ipairs(self.stldiagnostics) do
          count[diagnostic.severity] = count[diagnostic.severity] + 1
        end

        self.stldiagnosticserror = count[1]
        self.stldiagnosticswarn = count[2]
        self.stldiagnosticsinfo = count[3]
        self.stldiagnosticshint = count[4]
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
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.right_rounded,
  },
}

local Workspace = {
  {
    hl = {
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.left_rounded,
  },

  {
    hl = {
      bg = palette.catppuccin.base.hex,
      fg = palette.catppuccin.subtext0.hex,
    },
    init = function(self)
      setup_workspace(self)
    end,

    {
      update = { 'TermEnter', 'TermLeave' },
      condition = function(self)
        return self.stlbuftype == 'terminal'
      end,
      provider = 'term://',
    },
    {
      -- update = { 'DirChanged' },
      hl = {
        fg = palette.colorblind.blue.hex,
      },
      provider = function(self)
        return fnamemodify(self.stlcwd, ':~')
      end,
    },

    {
      update = { 'TermEnter', 'TermLeave' },
      condition = function(self)
        return self.stlbuftype == 'terminal'
      end,
      provider = function(self)
        local pattern = '//[%d%p]+' .. vim.o.shell .. '[%p%w]+$'

        return str_match(self.stlbufname, pattern)
      end,
    },
  },

  {
    hl = {
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.right_rounded,
  },
}

local FileType = {
  {
    hl = {
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.left_rounded,
  },
  {
    update = { 'DirChanged', 'BufEnter', 'BufLeave', 'BufWinEnter', 'BufWinLeave' },
    hl = {
      fg = palette.catppuccin.subtext0.hex,
      bg = palette.catppuccin.base.hex,
    },
    provider = function()
      return bo.filetype
    end,
  },
  {
    hl = {
      fg = palette.catppuccin.base.hex,
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

local WinBar = {
  init = heir_utils.pick_child_on_condition,
  hl = {
    bold = true,
    italic = true,
  },
  {
    condition = function()
      return heir_conds.buffer_matches {
        buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
        filetype = { 'fugitive', 'NvimTree', 'packer' },
      }
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
}

local FileName = {
  condition = function(self)
    setup_workspace(self)
    return self.stlbuftype == ''
  end,

  {
    hl = {
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.left_rounded,
  },
  {
    hl = {
      bg = palette.catppuccin.base.hex,
      fg = palette.catppuccin.subtext0.hex,
    },
    {
      update = { 'DirChanged', 'BufEnter', 'BufLeave', 'BufWinEnter', 'BufWinLeave' },
      provider = function(self)
        if str_find(self.stlbufname, self.stlcwd, 1, true) then
          local offset = #self.stlcwd
          if self.stlcwd == '/' then
            offset = offset - 1
          end
          return str_sub(self.stlbufname, offset + 2, -1)
        elseif self.stlbufname ~= '' then
          return fnamemodify(self.stlbufname, ':~')
        else
          return ''
        end
      end,
    },
    {
      condition = function()
        return not bo.readonly
      end,

      { provider = '[' },
      {
        condition = function()
          return bo.modified
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
    hl = {
      fg = palette.catppuccin.base.hex,
    },
    provider = sep.right_rounded,
  },
}

table.insert(WinBar, {
  FileName,
})

heirline.setup(StatusLine, WinBar)
