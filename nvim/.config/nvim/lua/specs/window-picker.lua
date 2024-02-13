return {
  's1n7ax/nvim-window-picker',
  keys = {
    {
      '<C-w><C-g>',
      function()
        local winid = require('window-picker').pick_window()
        if winid then
          ---@cast winid integer
          vim.api.nvim_set_current_win(winid)
        end
      end,
      mode = { 'n' },
    },
  },
  config = function()
    require('window-picker').setup {
      -- following filters are only applied when you are using the default filter
      -- defined by this plugin. If you pass in a function to "filter_func"
      -- property, you are on your own
      filter_rules = {
        -- when there is only one window available to pick from, use that window
        -- without prompting the user to select
        autoselect_one = true,

        -- whether you want to include the window you are currently on to window
        -- selection or not
        include_current_win = false,

        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { 'notify', 'noice' },

          -- if the file type is one of following, the window will be ignored
          buftype = {},
        },

        -- filter using window options
        wo = {},

        -- if the file path contains one of following names, the window
        -- will be ignored
        file_path_contains = {},

        -- if the file name contains one of following names, the window will be
        -- ignored
        file_name_contains = {},
      },
    }
  end,
}
