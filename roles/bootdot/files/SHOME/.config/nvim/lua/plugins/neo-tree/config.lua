require('neo-tree').setup {
  enable_diagnostics = false,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      with_markers = true,
      indent_marker = '│',
      last_indent_marker = '└',
      highlight = 'NeoTreeIndentMarker',
    },
  },
  filesystem = {
    use_libuv_file_watcher = true,
    window = {
      position = 'left',
      width = 30,
      mappings = {
        ['o'] = 'open',
      },
    },
  },
}
