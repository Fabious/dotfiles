return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
    'olimorris/neotest-phpunit',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-phpunit'),
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
