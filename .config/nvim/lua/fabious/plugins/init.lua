return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          {
            section = 'terminal',
            cmd = 'colorscript -e square',
            height = 5,
            padding = 1,
          },
          { icon = ' ', title = 'Files', section = 'recent_files', limit = 9, indent = 2, padding = 1 },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        },
      },
      lazygit = { enabled = true },
      toggle = { enabled = true },
      notifier = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
    },
  },

  -- Utils
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  },
}
