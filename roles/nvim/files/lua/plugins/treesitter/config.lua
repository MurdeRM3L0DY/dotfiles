local K = require 'utils.keymap'

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
  rainbow = {
    enable = true,
    extended_mode = true,
  },

  matchup = {
    enable = false, -- mandatory, false will disable the whole extension
  },

  textobjects = {
    enable = true,

    set_jumps = true, -- whether to set jumps in the jumplist

    goto_next_start = {
      [']m'] = '@function.outer',
      [']]'] = '@class.outer',
    },
    goto_next_end = {
      [']M'] = '@function.outer',
      [']['] = '@class.outer',
    },
    goto_previous_start = {
      ['[m'] = '@function.outer',
      ['[['] = '@class.outer',
    },
    goto_previous_end = {
      ['[M'] = '@function.outer',
      ['[]'] = '@class.outer',
    },

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
}

K.set('n', '<leader>th', '<cmd>TSHighlightCapturesUnderCursor<cr>')
K.set('n', '<leader>tn', '<cmd>TSNodeUnderCursor<cr>')
K.set('n', '<leader>pt', '<cmd>TSPlaygroundToggle<cr>')
