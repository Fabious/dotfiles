-- Three explorers, deliberately: oil edits directories as buffers, neo-tree is
-- the sidebar tree, yazi is the full TUI.
return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Neotree' },
    },
    opts = {
      close_if_last_window = true,
      window = {
        position = 'right',
      },
    },
  },

  {
    'mikavilpas/yazi.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      { '<leader>-', '<cmd>Yazi<cr>', mode = { 'n', 'v' }, desc = 'Open yazi at the current file' },
      { '<leader>cw', '<cmd>Yazi cwd<cr>', desc = "Open yazi in nvim's working directory" },
      { '<c-up>', '<cmd>Yazi toggle<cr>', desc = 'Resume the last yazi session' },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
    init = function()
      -- https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
