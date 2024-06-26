return {
  {
    'nvim-lspconfig',
    ft = { 'python' },
    opts = function(_, opts)
      local lspconfig = {
        configs = require('lspconfig.configs'),
        util = require('lspconfig.util'),
      }

      local function organize_imports()
        local params = {
          command = 'pylance.organizeimports',
          arguments = { vim.uri_from_bufnr(0) },
        }
        vim.lsp.buf.execute_command(params)
      end

      local root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
      }

      if not lspconfig.configs.pylance then
        lspconfig.configs.pylance = {
          default_config = {
            cmd = { 'pylance' },
            filetypes = { 'python' },
            single_file_support = true,
            root_dir = lspconfig.util.root_pattern(unpack(root_markers)),
            settings = {
              python = {
                analysis = {},
              },
            },
          },
          commands = {
            PylanceOrganizeImports = {
              organize_imports,
              description = 'Organize Imports',
            },
          },
        }
      end

      opts.servers.pylance = {
        before_init = function(_, config)
          local prefix = vim.env.CONDA_PREFIX ~= ('%s/miniconda3'):format(vim.env.HOME)
              and vim.env.CONDA_PREFIX
            or vim.env.VIRTUAL_ENV

          local defaultInterpreterPath = prefix and ('%s/bin/python'):format(prefix)
          config.settings.python = {
            defaultInterpreterPath = defaultInterpreterPath,
          }
        end,
      }

      opts.servers.ruff = {}
    end,
  },
  {
    'benlubas/molten-nvim',
    dependencies = {
      {
        'image.nvim',
        opts = {
          backend = 'kitty', -- whatever backend you would like to use
          max_width = 100,
          max_height = 12,
          max_height_window_percentage = math.huge,
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
        },
      },
    },
    build = ':UpdateRemotePlugins',
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
  },
  {
    'mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'ruff',
      })
    end,
  },
}
