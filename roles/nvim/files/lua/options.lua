local opt = vim.opt

-- general options
opt.hidden = true
opt.wrap = false
opt.shortmess:append 'cI'
opt.textwidth = 120
opt.scrolloff = 8
opt.swapfile = false
opt.timeout = true
opt.timeoutlen = 250
opt.updatetime = 200
opt.mouse = 'a'
opt.virtualedit = 'block'
opt.inccommand = 'split'
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.showmode = false
opt.signcolumn = 'yes:1'
opt.laststatus = 3
-- opt.formatoptions:remove 'ro'

vim.opt.fillchars:append {
  eob = ' ',
  diff = '╱',
  foldclose = '',
  foldopen = '',
}

opt.list = true
opt.listchars:append {
  tab = '▷⋯',
  space = '⋅',
  nbsp = '␣',
  trail = '•',
  eol = '↴',
}
opt.diffopt:append {
  'algorithm:histogram',
  'internal',
  'indent-heuristic',
  'filler',
  'closeoff',
  'iwhite',
  'vertical',
}
opt.shell = '/usr/bin/zsh'
opt.lazyredraw = true

-- /
opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = false

-- Completion Options
opt.complete = {}
opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
opt.pumheight = 8

-- Tab Size Options
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- System Wide Clipboard
opt.clipboard = 'unnamedplus'
