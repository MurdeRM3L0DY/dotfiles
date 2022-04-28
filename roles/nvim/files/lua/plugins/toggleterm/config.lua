local size = {
  horizontal = 15,
  vertical = vim.o.columns * 0.4,
}

require('toggleterm').setup {
  size = function(term)
    return size[term.direction]
  end,
  open_mapping = [[<C-\>]],
}
