return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    opts = {},
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { icon = ' ', title = 'Files', section = 'recent_files', limit = 9, indent = 2, padding = 1 },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          {
            icon = ' ',
            desc = 'Browse Repo',
            padding = 1,
            key = 'b',
            action = function()
              Snacks.gitbrowse()
            end,
          },
          {
            icon = ' ',
            desc = 'Diffview [l]ast commit',
            padding = 1,
            key = 'l',
            action = ':DiffviewOpen HEAD^',
          },
          {
            icon = ' ',
            desc = 'Diffview [h]istory',
            padding = 1,
            key = 'h',
            action = ':DiffviewFileHistory',
          },
          { section = 'startup' },
        },
      },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      toggle = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
    keys = {
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
      { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
      { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
      { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
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
