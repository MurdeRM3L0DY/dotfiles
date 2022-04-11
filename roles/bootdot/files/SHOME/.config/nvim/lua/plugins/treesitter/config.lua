local K = require 'utils.keymap'
local parsers = require 'nvim-treesitter.parsers'
local ft_to_parser = parsers.filetype_to_parsername
-- local parser_configs = parsers.get_parser_configs()

-- parser_configs.norg_meta = {
--   install_info = {
--     url = 'https://github.com/nvim-neorg/tree-sitter-norg-meta',
--     files = { 'src/parser.c' },
--     branch = 'main',
--   },
-- }
--
-- parser_configs.norg_table = {
--   install_info = {
--     url = 'https://github.com/nvim-neorg/tree-sitter-norg-table',
--     files = { 'src/parser.c' },
--     branch = 'main',
--   },
-- }

ft_to_parser['octo'] = 'markdown'

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c',
    'make',
    'lua',
    'bash',
    'query',
    'json',
    'jsonc',
    'javascript',
    'jsdoc',
    'typescript',
    'tsx',
    'css',
    'graphql',
    'python',
    'java',
    'rust',
    'toml',
    'yaml',
    'dart',
    'go',
    'gomod',
    'godot_resource',
    'dockerfile',
    'cpp',
    'nix',
    'vim',
    'latex',
    'norg',
    'norg_meta',
    'norg_table',
    'markdown',
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 10, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'InsertEnter', 'TextChangedI', 'TextChangedP' },
  },
  context_commentstring = {
    enable = false,
  },
  autopairs = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },

  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },

  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },

  endwise = {
    enable = true,
  },
}

K.set('n', '<leader>th', '<cmd>TSHighlightCapturesUnderCursor<cr>')

K.set('n', '<leader>pt', '<cmd>TSPlaygroundToggle<cr>')
