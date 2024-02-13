return {
  'nvim-neo-tree/neo-tree.nvim',
  -- enabled = false,
  cmd = { 'Neotree' },
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute { toggle = true }
      end,
      mode = { 'n' },
    },
  },
  config = function()
    require('neo-tree').setup {
      enable_git_status = true,
      enable_diagnostics = false,

      source_selector = {
        winbar = true,
      },

      default_component_configs = {
        indent = {
          indent_size = 1,
          padding = 0,
          with_markers = true,
        },
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      window = {
        position = 'left',
        width = 35,
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['D'] = 'fuzzy_finder_directory',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',
        },
      },
    }
  end,
}
