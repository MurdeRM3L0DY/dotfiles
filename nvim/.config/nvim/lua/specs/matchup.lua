return {
  'andymass/vim-matchup',
  event = { 'BufReadPost' },
  dependencies = {
    { 'nvim-treesitter' },
  },
  init = function()
    vim.g.matchup_matchparen_offscreen = {}
  end,
  config = function()
    require('nvim-treesitter.configs').setup {
      matchup = {
        enable = true,
        include_match_words = true,
        disable_virtual_text = true,
      },
    }
  end,
}
