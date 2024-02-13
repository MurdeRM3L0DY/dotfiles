return {
  'ray-x/lsp_signature.nvim',
  -- event = 'VeryLazy',
  opts = {},
  init = function()
    -- require('utils.lsp').on_attach(function(client, bufnr)
    --   require('lsp_signature').on_attach({
    --     bind = true, -- This is mandatory, otherwise border config won't get registered.
    --     hint_enable = false,
    --     hint_prefix = '',
    --     max_height = 4,
    --     handler_opts = {
    --       border = 'single',
    --     },
    --     timer_interval = 25,
    --   }, bufnr)
    -- end)
  end,
}
