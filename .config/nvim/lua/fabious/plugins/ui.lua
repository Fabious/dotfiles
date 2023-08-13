return {

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    opts = {
      options = {
        mode = 'buffers',
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
        separator_style = 'slant',
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
    keys = {
      { '<A-1>', '<cmd>BufferLineGoToBuffer 1<CR>' },
      { '<A-2>', '<cmd>BufferLineGoToBuffer 2<CR>' },
      { '<A-3>', '<cmd>BufferLineGoToBuffer 3<CR>' },
      { '<A-4>', '<cmd>BufferLineGoToBuffer 4<CR>' },
      { '<A-5>', '<cmd>BufferLineGoToBuffer 5<CR>' },
      { '<A-6>', '<cmd>BufferLineGoToBuffer 6<CR>' },
      { '<A-7>', '<cmd>BufferLineGoToBuffer 7<CR>' },
      { '<A-8>', '<cmd>BufferLineGoToBuffer 8<CR>' },
      { '<A-9>', '<cmd>BufferLineGoToBuffer 9<CR>' },
      { '<C-1>', '<cmd>BufferLineGoToBuffer 1<CR>' },
      { '<C-2>', '<cmd>BufferLineGoToBuffer 2<CR>' },
      { '<C-3>', '<cmd>BufferLineGoToBuffer 3<CR>' },
      { '<C-4>', '<cmd>BufferLineGoToBuffer 4<CR>' },
      { '<C-5>', '<cmd>BufferLineGoToBuffer 5<CR>' },
      { '<C-6>', '<cmd>BufferLineGoToBuffer 6<CR>' },
      { '<C-7>', '<cmd>BufferLineGoToBuffer 7<CR>' },
      { '<C-8>', '<cmd>BufferLineGoToBuffer 8<CR>' },
      { '<C-9>', '<cmd>BufferLineGoToBuffer 9<CR>' },
    },
  },

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
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
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },

  -- Indent Blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    opts = {
      buftype_exclude = { 'terminal' },
      char = '▏',
      filetype_exclude = { 'help', 'NvimTree', 'dashboard', 'packer', 'TelescopePrompt', 'alpha' },
      show_current_context = true,
      space_char_blankline = ' ',
      use_treesitter = true,
    },
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
          { cursor = '', texthl = 'SmoothCursorRed' },
          { cursor = '', texthl = 'SmoothCursorOrange' },
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
}
