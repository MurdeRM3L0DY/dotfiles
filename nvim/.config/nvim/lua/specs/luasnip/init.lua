local require = _G.require_lazy

local ls = require('luasnip')

local luasnip_jump = function(dir)
  if ls.jumpable(dir) then
    ls.jump(dir)
  end
end

local luasnip_change_choice = function(dir)
  if ls.choice_active() then
    ls.change_choice(dir)
  end
end

return {
  {
    'L3MON4D3/LuaSnip',
    keys = {
      {
        '<C-j>',
        function()
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end,
        mode = { 'i' },
      },
      {
        '<C-j>',
        function()
          luasnip_jump(1)
        end,
        mode = { 's' },
      },
      {
        '<C-k>',
        function()
          luasnip_jump(-1)
        end,
        mode = { 'i', 's' },
      },
      {
        '<C-e>',
        function()
          luasnip_change_choice(1)
        end,
        mode = { 'i', 's' },
      },
    },
    config = function()
      local types = require('luasnip.util.types')

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LuasnipPreExpand',
        callback = function()
          -- get event-parameters from `session`.
          local lsess = require('luasnip').session

          local snippet = lsess.event_node
          local expand_position = lsess.event_args.expand_pos

          -- require('cmp').complete {
          --   config = {
          --     sources = {
          --       { name = 'luasnip' },
          --     },
          --   },
          -- }

          -- print(
          --   string.format(
          --     'expanding snippet %s at %s:%s',
          --     table.concat(snippet:get_docstring(), '\n'),
          --     expand_position[1],
          --     expand_position[2]
          --   )
          -- )
        end,
      })

      ls.config.setup {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
        delete_check_events = 'TextChanged,TextChangedI',
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { '', 'Identifier' } },
            },
          },
        },
      }

      for _, i in ipairs { 'lua', 'snipmate', 'vscode' } do
        require('luasnip.loaders.from_' .. i).lazy_load {
          paths = vim.fn.stdpath('config') .. '/lua/specs/luasnip/snippets/' .. i,
        }
      end
    end,
  },
  {
    'nvim-cmp',
    dependencies = {
      { 'saadparwaiz1/cmp_luasnip' },
    },
    opts = function(_, opts)
      local cmp = require('cmp')

      vim.list_extend(
        opts.sources,
        cmp.config.sources {
          { name = 'luasnip' },
        }
      )

      function opts.snippet.expand(args)
        require('luasnip').lsp_expand(args.body)
      end
    end,
  },
}
