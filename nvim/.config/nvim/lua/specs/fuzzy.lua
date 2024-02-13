return {
  {
    'ibhagwan/fzf-lua',
    cmd = { 'FzfLua' },
    event = { 'LspAttach' },
    dependencies = {
      { 'nvim-treesitter' },
    },
    keys = function()
      require('config.lsp.keys').update {
        {
          '<leader>ca',
          function()
            require('fzf-lua').lsp_code_actions { git_icons = false, file_icons = false }
          end,
        },
        {
          'gr',
          function()
            require('fzf-lua').lsp_references { git_icons = false, file_icons = false }
          end,
        },
        {
          'gd',
          function()
            require('fzf-lua').lsp_definitions { git_icons = false, file_icons = false }
          end,
        },
        {
          'gt',
          function()
            require('fzf-lua').lsp_typedefs { git_icons = false, file_icons = false }
          end,
        },
        {
          'gi',
          function()
            require('fzf-lua').lsp_implementations { git_icons = false, file_icons = false }
          end,
        },
        {
          '<leader>ss',
          function()
            require('fzf-lua').lsp_workspace_symbols { git_icons = false, file_icons = false }
          end,
        },
      }

      return {
        {
          '<C-p>',
          function()
            require('fzf-lua').files {
              cmd = 'rg --files --hidden -g "!{**/node_modules/**,**/.git/**,**/.direnv/**,**/.cache/**,**/target/**}"',
              git_icons = false,
              file_icons = false,
            }
          end,
          mode = { 'n' },
        },
        {
          '<leader>gl',
          function()
            require('fzf-lua').live_grep {
              hidden = true,
              git_icons = false,
              file_icons = false,
            }
          end,
        },
      }
    end,
    config = function()
      require('fzf-lua').setup {
        winopts = {
          border = 'single',
          preview = {
            enable = false,
            delay = 10,
          },
        },
      }
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    keys = {
      {
        '<leader>ff',
        '<cmd>Telescope find_files<cr>',
        mode = { 'n' },
      },
    },
    dependencies = {
      { 'nvim-treesitter' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local TSLayout = require('telescope.pickers.layout')
      local TSActions = require('telescope.actions')
      local NuiLayout = require('nui.layout')
      local NuiPopup = require('nui.popup')
      local NuiSplit = require('nui.split')

      require('telescope').setup {
        defaults = {
          borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          mappings = {
            i = {
              ['<esc>'] = TSActions.close,
            },
          },
          ---@param picker Picker
          -- create_layout = function(picker)
          --   local results = NuiPopup {
          --     win_options = {
          --       number = false,
          --       relativenumber = false,
          --       -- winbar = picker.results_title,
          --     },
          --   }
          --
          --   local prompt = NuiPopup {
          --     win_options = {
          --       cursorline = false,
          --       number = false,
          --       relativenumber = false,
          --       -- winbar = picker.prompt_title,
          --     },
          --   }
          --
          --   local preview = NuiPopup {
          --     win_options = {
          --       number = true,
          --       relativenumber = false,
          --       -- winbar = picker.preview_title,
          --     },
          --   }
          --
          --   local box_by_kind = {
          --     vertical = NuiLayout.Box({
          --       NuiLayout.Box(preview, { grow = 1 }),
          --       NuiLayout.Box(results, { grow = 1 }),
          --       NuiLayout.Box(prompt, { size = 2 }),
          --     }, { dir = 'col' }),
          --     horizontal = NuiLayout.Box({
          --       NuiLayout.Box({
          --         NuiLayout.Box(results, { grow = 1 }),
          --         NuiLayout.Box(prompt, { size = 2 }),
          --       }, { dir = 'col', size = '50%' }),
          --       NuiLayout.Box(preview, { size = '50%' }),
          --     }, { dir = 'row' }),
          --     minimal = NuiLayout.Box({
          --       NuiLayout.Box(results, { grow = 1 }),
          --       NuiLayout.Box(prompt, { size = 2 }),
          --     }, { dir = 'col' }),
          --   }
          --
          --   local function get_box()
          --     local height, width = vim.o.lines, vim.o.columns
          --     local box_kind = 'horizontal'
          --     if width < 100 then
          --       box_kind = 'vertical'
          --       if height < 40 then
          --         box_kind = 'minimal'
          --       end
          --     elseif width < 120 then
          --       box_kind = 'minimal'
          --     end
          --     return box_by_kind[box_kind], box_kind
          --   end
          --
          --   local function prepare_layout_parts(layout, box_type)
          --     layout.results = TSLayout.Window(results)
          --
          --     layout.prompt = TSLayout.Window(prompt)
          --
          --     if box_type == 'minimal' then
          --       layout.preview = nil
          --     else
          --       layout.preview = TSLayout.Window(preview)
          --     end
          --   end
          --
          --   local box, box_kind = get_box()
          --   local layout = NuiLayout({
          --     relative = 'editor',
          --     position = 'bottom',
          --     size = '60%',
          --   }, box)
          --
          --   layout.picker = picker
          --   prepare_layout_parts(layout, box_kind)
          --
          --   return TSLayout(layout)
          --   -- local preview = NuiPopup {
          --   --   focusable = false,
          --   --   border = {
          --   --     style = "single",
          --   --     text = {
          --   --       top = picker.preview_title,
          --   --       top_align = 'center',
          --   --     },
          --   --   },
          --   --   win_options = {
          --   --     winhighlight = 'Normal:Normal',
          --   --   },
          --   -- }
          --   -- local prompt = NuiPopup {
          --   --   enter = true,
          --   --   border = {
          --   --     style = "single",
          --   --     text = {
          --   --       top = picker.prompt_title,
          --   --       top_align = 'center',
          --   --     },
          --   --   },
          --   --   win_options = {
          --   --     winhighlight = 'Normal:Normal',
          --   --   },
          --   -- }
          --   -- local results = NuiPopup {
          --   --   focusable = false,
          --   --   border = {
          --   --     style = "single",
          --   --     text = {
          --   --       top = picker.results_title,
          --   --       top_align = 'center',
          --   --     },
          --   --   },
          --   --   win_options = {
          --   --     winhighlight = 'Normal:Normal',
          --   --   },
          --   -- }
          --   --
          --   -- local box = NuiLayout.Box({
          --   --   NuiLayout.Box({
          --   --     NuiLayout.Box(results, { grow = 1 }),
          --   --     NuiLayout.Box(prompt, { size = 3 }),
          --   --   }, { dir = 'col', size = '50%' }),
          --   --   NuiLayout.Box(preview, { size = '50%' }),
          --   -- }, { dir = 'row' })
          --   --
          --   -- local layout = NuiLayout({}, box)
          --   -- layout.preview = TSLayout.Window(preview)
          --   -- layout.prompt = TSLayout.Window(prompt)
          --   -- layout.results = TSLayout.Window(results)
          --   --
          --   -- local update = layout.update
          --   -- function layout:update()
          --   --   update(self, box)
          --   -- end
          --   --
          --   -- return TSLayout(layout)
          -- end,
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      }

      require('telescope').load_extension('fzf')
    end,
  },
}
