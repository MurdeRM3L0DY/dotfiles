local augroup = require 'utils.augroup'
local NVIM_TREE_AUGROUP = augroup('NVIM_TREE_AUGROUP', { clear = true })

require('nvim-tree').setup {
  indent_markers = true,
  -- disables netrw completely
  disable_netrw = true,
  -- hijack netrw window on startup
  hijack_netrw = true,
  -- open the tree when running this setup function
  open_on_setup = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup = {},
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd = true,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd = true,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {},
  },

  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = true,
        exclude = {
          filetype = {
            'notify',
            'packer',
            'qf',
          },
          buftype = {
            'terminal',
          },
        },
      },
    },
  },

  git = {
    ignore = false,
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd = nil,
    -- the command arguments as a list
    args = {},
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {
        { key = 'l', action = 'edit' },
        { key = 'h', action = 'close_node' },
      },
    },
  },
}

-- NVIM_TREE_AUGROUP(function(autocmd)
--   autocmd('BufEnter', {
--     nested = true,
--     callback = function()
--       local current_buf_name = vim.api.nvim_buf_get_name(0)
--       if
--         vim.api.nvim_win_get_number(0) == 1
--         and current_buf_name:match('NvimTree_' .. vim.api.nvim_win_get_tabpage(0))
--       then
--         -- print 'hi'
--         -- vim.api.nvim_win_close(0, true)
--       end
--     end,
--     -- command = 'if winnr("$") == 1 && bufname() == "NvimTree_" . tabpagenr() | quit | endif',
--   })
-- end)
--
-- vim.api.nvim_command [[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]
