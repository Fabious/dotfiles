-- Exactly one colorscheme may be non-lazy. Previously kanagawa and
-- solarized-osaka both loaded eagerly and kanagawa won only on load order.
return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
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

  -- Switchable with :colorscheme <name>; lazy.nvim loads them on ColorSchemePre.
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
  { 'catppuccin/nvim', name = 'catppuccin', lazy = true },
}
