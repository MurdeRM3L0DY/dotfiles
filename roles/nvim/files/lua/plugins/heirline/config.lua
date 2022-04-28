local augroup = require 'utils.augroup'
local HEIRLINE_AUGROUP = augroup('HEIRLINE_AUGROUP', {})

local heirline = require 'heirline'
local heir_utils = require 'heirline.utils'

local palette = require('colorblind.theme').Colorblind.lush
local separators = {
  vertical_bar = '┃',
  vertical_bar_thin = '│',
  left = '',
  right = '',
  block = '█',
  block_thin = '▌',
  left_filled = '',
  right_filled = '',
  slant_left = '',
  slant_left_thin = '',
  slant_right = '',
  slant_right_thin = '',
  slant_left_2 = '',
  slant_left_2_thin = '',
  slant_right_2 = '',
  slant_right_2_thin = '',
  left_rounded = '',
  left_rounded_thin = '',
  right_rounded = '',
  right_rounded_thin = '',
  circle = '●',
}

local get_icon = function(file_name, file_ext)
  local icon, hl = require('nvim-web-devicons').get_icon(file_name, file_ext, { default = false })
  return icon, hl
end

local mode_map = {
  ['n'] = { 'NORMAL', 'Normal' },
  ['no'] = { 'O-PENDING', 'Visual' },
  ['nov'] = { 'O-PENDING', 'Visual' },
  ['noV'] = { 'O-PENDING', 'Visual' },
  ['no'] = { 'O-PENDING', 'Visual' },
  ['nt'] = { 'T-NORMAL', 'Normal' },
  ['niI'] = { 'NORMAL', 'Normal' },
  ['niR'] = { 'NORMAL', 'Normal' },
  ['niV'] = { 'NORMAL', 'Normal' },
  ['v'] = { 'VISUAL', 'Visual' },
  ['V'] = { 'V-LINE', 'Visual' },
  [''] = { 'V-BLOCK', 'Visual' },
  ['s'] = { 'SELECT', 'Visual' },
  ['S'] = { 'S-LINE', 'Visual' },
  [''] = { 'S-BLOCK', 'Visual' },
  ['i'] = { 'INSERT', 'Insert' },
  ['ic'] = { 'INSERT', 'Insert' },
  ['ix'] = { 'INSERT', 'Insert' },
  ['R'] = { 'REPLACE', 'Replace' },
  ['Rc'] = { 'REPLACE', 'Replace' },
  ['Rv'] = { 'V-REPLACE', 'Normal' },
  ['Rx'] = { 'REPLACE', 'Normal' },
  ['Rvc'] = { 'V-REPLACE', 'Replace' },
  ['Rvx'] = { 'V-REPLACE', 'Replace' },
  ['c'] = { 'COMMAND', 'Command' },
  ['cv'] = { 'EX', 'Command' },
  ['ce'] = { 'EX', 'Command' },
  ['r'] = { 'REPLACE', 'Replace' },
  ['rm'] = { 'MORE', 'Normal' },
  ['r?'] = { 'CONFIRM', 'Normal' },
  ['!'] = { 'SHELL', 'Normal' },
  ['t'] = { 'TERMINAL', 'Command' },
}

local StatusLine = {}

local function insert(component)
  table.insert(StatusLine, component)
end

local align = function()
  table.insert(StatusLine, {
    provider = '%=',
  })
end

local ViMode = heir_utils.surround(
  { separators.left_rounded, separators.right_rounded },
  palette.colorblind.flickeryc64.hex,
  {
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
)

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

local Position = {
  provider = function()
    return '%4l:%-3v'
  end,
}

local Git = {
  condition = function()
    return vim.b.gitsigns_status_dict ~= nil
  end,
  init = function(self)
    self.status = vim.b.gitsigns_status_dict
  end,
  {
    provider = function(self)
      if self.status.added then
        return '+' .. self.status.added
      end
    end,
    hl = {
      fg = palette.colorblind.infraredgloze.hex,
    },
  },
  Space,
  {
    provider = function(self)
      if self.status.changed then
        return '~' .. self.status.changed
      end
    end,
    hl = {
      fg = palette.catppuccin.yellow.hex,
    },
  },
  Space,
  {
    provider = function(self)
      if self.status.removed then
        return '-' .. self.status.removed
      end
    end,
    hl = {
      fg = palette.colorblind.navigator.hex,
    },
  },
}

insert(ViMode)
insert(Git)
align()
insert {
  provider = '%f',
}
align()
insert(Position)

HEIRLINE_AUGROUP(function(au)
  au.create({ 'ColorScheme' }, {
    callback = function()
      heirline.reset_highlights()
    end,
  })
end)

heirline.setup(StatusLine)
