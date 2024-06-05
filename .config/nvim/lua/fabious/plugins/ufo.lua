-- Fold plugin
-- usage: za, zr, zm...
-- https://github.com/kevinhwang91/nvim-ufo
return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    })
  end,
  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
    },
  },
}
