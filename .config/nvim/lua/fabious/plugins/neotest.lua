local Plugin = { 'nvim-neotest/neotest' }

Plugin.dependencies = {
  'nvim-lua/plenary.nvim',
  'nvim-treesitter/nvim-treesitter',
  'antoinemadec/FixCursorHold.nvim',

  -- Go
  'nvim-neotest/neotest-go',
}

function Plugin.config()
  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace('neotest')
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
        return message
      end,
    },
  }, neotest_ns)

  require('neotest').setup({
    adapters = {
      require('neotest-go'),
    },
  })
end

Plugin.keys = {
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
}

return Plugin
