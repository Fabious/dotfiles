return {

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    lazy = false, -- avoid flickering on start
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {},
        lualine_y = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = { { 'filename', path = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            mode = 0,
            buffers_color = {
              -- active = { bg = '#d8a657', fg = '#1d1d1d', gui = 'bold' },
              -- inactive = { bg = '#444444', fg = '#fff4d2', gui = 'italic' },
            },
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'grapple' },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },

  -- Indent Blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    config = function()
      local highlight = {
        'RainbowViolet',
      }
      local hooks = require('ibl.hooks')
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
      end)

      require('ibl').setup({
        indent = {
          char = '▏',
        },
        scope = {
          highlight = highlight,
        },
        exclude = {
          filetypes = { 'help', 'NvimTree', 'dashboard', 'packer', 'TelescopePrompt', 'alpha' },
          buftypes = { 'terminal' },
        },
      })
    end,
  },

  -- SmoothCursor
  {
    'gen740/SmoothCursor.nvim',
    event = 'VeryLazy',
    opts = {
      autostart = true,
      cursor = '', -- cursor shape (need nerd font)
      texthl = 'SmoothCursor', -- highlight group, default is { bg = nil, fg = "#FFD400" }
      linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
      type = 'default', -- define cursor movement calculate function, "default" or "exp" (exponential).
      fancy = {
        enable = true, -- enable fancy mode
        head = { cursor = '▷', texthl = 'SmoothCursor', linehl = nil },
        body = {
          { cursor = '󰝥', texthl = 'SmoothCursorRed' },
          { cursor = '󰝥', texthl = 'SmoothCursorOrange' },
          { cursor = '●', texthl = 'SmoothCursorYellow' },
          { cursor = '●', texthl = 'SmoothCursorGreen' },
          { cursor = '•', texthl = 'SmoothCursorAqua' },
          { cursor = '.', texthl = 'SmoothCursorBlue' },
          { cursor = '.', texthl = 'SmoothCursorPurple' },
        },
        tail = { cursor = nil, texthl = 'SmoothCursor' },
      },
      flyin_effect = nil, -- "bottom" or "top"
      speed = 25, -- max is 100 to stick to your current position
      intervals = 35, -- tick interval
      priority = 10, -- set marker priority
      timeout = 3000, -- timout for animation
      threshold = 3, -- animate if threshold lines jump
      disable_float_win = true, -- disable on float window
      enabled_filetypes = nil, -- example: { "lua", "vim" }
      disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
    },
  },

  -- Fidget (notifications and LSP progress messages)
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      -- options
    },
  },

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = {},
  },
}
