return {
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      transparent = false,
      dimInactive = true,
      terminalColors = true,
      theme = 'wave',
      background = {
        dark = 'wave',
        light = 'lotus',
      },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd.colorscheme('kanagawa')
    end,
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
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
      inverse = true,
      contrast = '',
    },
  },
  {
    -- Matches kitty and zellij
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha',
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  { 'maxmx03/solarized.nvim', lazy = true, opts = {} },
}
