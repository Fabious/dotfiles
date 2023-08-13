return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-h>'] = 'which_key',
          },
        },
      },
    },
    keys = {
      { '<C-p>', '<cmd>Telescope git_files<cr>', desc = 'Fuzzy finder' },
      { '<C-g>', '<cmd>Telescope live_grep<cr>', desc = 'Live [G]rep' },
      { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = 'Find existing buffers' },
      -- find
      { '<leader>h', '<cmd>Telescope oldfiles<cr>', desc = 'Files [H]istory' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[F]ind [F]iles' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = '[F]ind [H]elp' },
      { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = '[F]ind current [W]ord' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = '[F]ind [D]iagnostics' },
      -- git
      { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'commits' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'status' },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable('make') == 1,
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
}
