return {
  -- Startup plugin
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },

  -- Utils
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  },
}
