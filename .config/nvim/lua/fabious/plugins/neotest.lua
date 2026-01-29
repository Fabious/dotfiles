return {
  'nvim-neotest/neotest',
  dependencies = {
    'antoinemadec/FixCursorHold.nvim',
    'marilari88/neotest-vitest',
    'nvim-lua/plenary.nvim',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/nvim-nio',
    'nvim-treesitter/nvim-treesitter',
    'olimorris/neotest-phpunit',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-phpunit'),
        require('neotest-vitest'),
        require('neotest-jest')({
          jestCommand = 'npm test --',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      desc = 'Run File',
    },
    {
      '<leader>tT',
      function()
        require('neotest').run.run(vim.loop.cwd())
      end,
      desc = 'Run All Test Files',
    },
    {
      '<leader>tr',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run Nearest',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle Summary',
    },
  },
}
