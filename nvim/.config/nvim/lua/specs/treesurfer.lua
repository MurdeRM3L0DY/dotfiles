return {
  'ziontee113/syntax-tree-surfer',
  keys = {
    {
      'J',
      function()
        require('syntax-tree-surfer').surf('next', 'visual')
      end,
      mode = { 'x' },
    },
    {
      'K',
      function()
        require('syntax-tree-surfer').surf('prev', 'visual')
      end,
      mode = { 'x' },
    },
    {
      'H',
      function()
        require('syntax-tree-surfer').surf('parent', 'visual')
      end,
      mode = { 'x' },
    },
    {
      'L',
      function()
        require('syntax-tree-surfer').surf('child', 'visual')
      end,
      mode = { 'x' },
    },
    {
      '<M-j>',
      function()
        require('syntax-tree-surfer').surf('next', 'visual', true)
      end,
      mode = { 'x' },
    },
    {
      '<M-k>',
      function()
        require('syntax-tree-surfer').surf('prev', 'visual', true)
      end,
      mode = { 'x' },
    },
  },
}
