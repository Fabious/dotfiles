return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
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
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    config = function()
      require('kanagawa').setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          return {
            --   Visual = {
            --     bg = theme.ui.fg,
            --     fg = theme.ui.bg,
            --   },
          }
        end,
        theme = 'wave', -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = 'wave', -- try "dragon" !
          light = 'lotus',
        },
      })
      vim.cmd('colorscheme kanagawa')
    end,
  },
  { 'talha-akram/noctis.nvim', lazy = true },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
  {
    'rose-pine/neovim',
    lazy = true,
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        dark_variant = 'moon',
      })
      vim.cmd('colorscheme rose-pine')
    end,
  },
  {
    'neanias/everforest-nvim',
    version = false,
    lazy = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('everforest').setup({
        ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
        ---Default is "medium".
        background = 'hard',
        ---How much of the background should be transparent. 2 will have more UI
        ---components be transparent (e.g. status line background)
        transparent_background_level = 0,
        ---Whether italics should be used for keywords and more.
        italics = false,
        ---Disable italic fonts for comments. Comments are in italics by default, set
        ---this to `true` to make them _not_ italic!
        disable_italic_comments = false,
        ---By default, the colour of the sign column background is the same as the as normal text
        ---background, but you can use a grey background by setting this to `"grey"`.
        sign_column_background = 'none',
        ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
        ---`"low"` (default).
        ui_contrast = 'low',
        ---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
        ---
        ---When this option is used in conjunction with show_eob set to `false`, the
        ---end of the buffer will only be hidden inside the active window. Inside
        ---inactive windows, the end of buffer filler characters will be visible in
        ---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
        dim_inactive_windows = false,
        ---Some plugins support highlighting error/warning/info/hint texts, by
        ---default these texts are only underlined, but you can use this option to
        ---also highlight the background of them.
        diagnostic_text_highlight = false,
        ---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
        diagnostic_virtual_text = 'coloured',
        ---Some plugins support highlighting error/warning/info/hint lines, but this
        ---feature is disabled by default in this colour scheme.
        diagnostic_line_highlight = false,
        ---By default, this color scheme won't colour the foreground of |spell|, instead
        ---colored under curls will be used. If you also want to colour the foreground,
        ---set this option to `true`.
        spell_foreground = false,
        ---Whether to show the EndOfBuffer highlight.
        show_eob = true,
        ---Style used to make floating windows stand out from other windows. `"bright"`
        ---makes the background of these windows lighter than |hl-Normal|, whereas
        ---`"dim"` makes it darker.
        ---
        ---Floating windows include for instance diagnostic pop-ups, scrollable
        ---documentation windows from completion engines, overlay windows from
        ---installers, etc.
        ---
        ---NB: This is only significant for dark backgrounds as the light palettes
        ---have the same colour for both values in the switch.
        float_style = 'bright',
        ---Inlay hints are special markers that are displayed inline with the code to
        ---provide you with additional information. You can use this option to customize
        ---the background color of inlay hints.
        ---
        ---Options are `"none"` or `"dimmed"`.
        inlay_hints_background = 'none',
        ---You can override specific highlights to use other groups or a hex colour.
        ---This function will be called with the highlights and colour palette tables.
        ---@param hl Highlights
        ---@param palette Palette
        ---@diagnostic disable-next-line: unused-local
        on_highlights = function(hl, palette)
          hl.LspReferenceRead = { fg = palette.purple, bg = palette.none, bold = true }
          hl.LspReferenceText = { fg = palette.purple, bg = palette.none, bold = true }
        end,
        ---You can override colours in the palette to use different hex colours.
        ---This function will be called once the base and background colours have
        ---been mixed on the palette.
        ---@param palette Palette
        ---@diagnostic disable-next-line: unused-local
        colours_override = function(palette) end,
      })
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('bamboo').setup({
        -- optional configuration here
      })
      require('bamboo').load()
    end,
  },
}
