return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = '', -- can be "hard", "soft" or empty string
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
    config = function(_, opts)
      require('gruvbox').setup(opts)
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  { 'EdenEast/nightfox.nvim', lazy = true },
  { 'folke/tokyonight.nvim', lazy = true },
  { 'rebelot/kanagawa.nvim', lazy = true },
  { 'talha-akram/noctis.nvim', lazy = true },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    priority = 1000,
    opts = {
      transparent_background = true, -- disables setting the background color.
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
