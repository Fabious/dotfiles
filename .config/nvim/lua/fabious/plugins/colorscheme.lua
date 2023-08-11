return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
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
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
  },
  {
    'sainnhe/everforest',
    lazy = true,
  },
  {
    'B4mbus/oxocarbon-lua.nvim',
    lazy = true,
  },
}
