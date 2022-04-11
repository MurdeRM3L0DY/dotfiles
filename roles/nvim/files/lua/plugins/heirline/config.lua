local StatusLine = {}

local function insert(component)
  table.insert(StatusLine, component)
end

local align = function()
  table.insert(StatusLine, {
    provider = '%=',
  })
end

local ViMode = {
  init = function(self)
    self.mode = vim.api.nvim_get_mode().mode
  end,
  static = {
    mode_names = {
      n = 'NORMAL',
      no = 'N?',
      nov = 'N?',
      noV = 'N?',
      ['no\22'] = 'N?',
      niI = 'Ni',
      niR = 'Nr',
      niV = 'Nv',
      nt = 'N.TERMINAL',
      v = 'VISUAL',
      vs = 'Vs',
      V = 'V.LINE',
      Vs = 'Vs',
      ['\22'] = 'V.BLOCK',
      ['\22s'] = '^V',
      s = 'SELECT',
      S = 'S.LINE',
      ['\19'] = '^S',
      i = 'INSERT',
      -- ic = 'Ic',
      -- ix = 'Ix',
      R = 'REPLACE',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'COMMAND',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = 'TERMINAL',
    },
  },
  provider = function(self)
    return self.mode_names[self.mode]
  end,
}

local Position = {
  provider = function()
    return '%l:%c'
  end,
}

insert(ViMode)
align()
insert {
  provider = '%f',
}
align()
insert(Position)

require('heirline').setup(StatusLine)
