local K = require 'utils.keymap'
local g = vim.g

g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_root_folder_modifier = ':~'
g.nvim_tree_add_trailing = 0
g.nvim_tree_group_empty = 1
g.nvim_tree_icon_padding = ' '
g.nvim_tree_symlink_arrow = ' ➛ '
g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_create_in_closed_folder = 0
g.nvim_tree_refresh_wait = 500

g.nvim_tree_special_files = {
  ['README.md'] = 1,
  ['Makefile'] = 1,
  ['MAKEFILE'] = 1,
}
g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 0,
}

g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '',
    staged = '',
    unmerged = '',
    renamed = '',
    untracked = '',
    deleted = '',
    ignored = '',
  },
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  },
}

K.set('n', '<leader>e', function()
  require('nvim-tree').toggle()
end, { desc = '(nvim-tree): Toggle File Explorer' })
