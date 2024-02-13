return {
  {
    'ggandor/leap.nvim',
    init = function(p)
      require('lazy.core.loader').disable_rtp_plugin(p.name)
    end,
  },
  {
    'ggandor/flit.nvim',
    -- enabled = false,
    keys = {
      { 'f', mode = { 'n', 'x', 'o' } },
      { 'F', mode = { 'n', 'x', 'o' } },
      { 't', mode = { 'n', 'x', 'o' } },
      { 'T', mode = { 'n', 'x', 'o' } },
    },
    config = function()
      require('flit').setup {
        labeled_modes = 'nv',
      }
    end,
  },
  {
    'ggandor/leap-spooky.nvim',
    -- enabled = false,
    keys = {
      { 'r', mode = { 'x', 'o' } },
      { 'R', mode = { 'x', 'o' } },
      { 'm', mode = { 'x', 'o' } },
      { 'M', mode = { 'x', 'o' } },
    },
    config = function()
      require('leap-spooky').setup {}
    end,
  },
}
