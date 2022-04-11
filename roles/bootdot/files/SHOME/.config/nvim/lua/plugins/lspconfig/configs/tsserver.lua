local K = require 'utils.keymap'
local ts_utils = require 'nvim-lsp-ts-utils'

local ts_utils_on_attach = function(client, bufnr)
  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,

    -- import all
    import_all_timeout = 5000, -- ms
    import_all_priorities = {
      buffers = 4, -- loaded buffer names
      buffer_content = 3, -- loaded buffer content
      local_files = 2, -- git files or files with relative path markers
      same_file = 1, -- add to existing import statement
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,

    -- Linter
    -- eslint_enable_code_actions = false,
    -- eslint_enable_diagnostics = false,
    -- eslint_enable_disable_comments = false,
    -- eslint_diagnostics_debounce = 250,
    -- eslint_bin = "eslint_d",
    -- eslint_opts = {
    --   condition = function(utils)
    --     utils.root_has_file "node_modules/.bin/eslint_d"
    --   end,
    --   diagnostics_format = " #{m} [#{c}]",
    -- },

    -- Formatter
    enable_formatting = true,
    formatter = 'prettier_d_slim',
    formatter_opts = nil,

    -- Inlay Hints
    auto_inlay_hints = true,
    inlay_hints_highlight = 'Comment',
    inlay_hints_priority = 200, -- priority of the hint extmarks
    inlay_hints_throttle = 150, -- throttle the inlay hint request
    inlay_hints_format = { -- format options for individual hint kind
      Parameter = {
        ---format text
        ---@param text string
        ---@return string
        text = function(text)
          return ('<- (%s)'):format(text:sub(1, -2))
        end,
      },
      Type = {},
      Enum = {},
      -- Example format customization for `Type` kind:
      -- Type = {
      --     highlight = "Comment",
      -- },
    },
  }

  ts_utils.setup_client(client)

  local opts = { buffer = bufnr }
  K.set('n', '<leader>gs', '<CMD>TSLspOrganize<CR>', opts)
  K.set('n', '<leader>gq', '<CMD>TSLspFixCurrent<CR>', opts)
  K.set('n', '<leader>gr', '<CMD>TSLspRenameFile<CR>', opts)
  K.set('n', '<leader>gi', '<CMD>TSLspImportAll<CR>', opts)
end

return {
  init_options = require('nvim-lsp-ts-utils.utils').init_options,

  on_attach = function(client, bufnr)
    ts_utils_on_attach(client, bufnr)
  end,
}
