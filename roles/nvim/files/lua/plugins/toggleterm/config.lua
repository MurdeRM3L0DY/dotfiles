local size = {
  horizontal = 15,
  vertical = vim.o.columns * 0.4,
}

require('toggleterm').setup {
  open_mapping = [[<C-\>]],
  size = function(term)
    return size[term.direction]
  end,
  shade_terminals = false,
}
