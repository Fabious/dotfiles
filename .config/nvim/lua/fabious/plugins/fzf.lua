return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup({
        fzf_opts = {
          ['--layout'] = 'reverse', -- default
        },
      })
    end,
    keys = {
      { '<C-p>', '<Cmd>lua require"fzf-lua".files()<CR>', desc = 'Files' },
      { '<C-g>', '<Cmd>lua require"fzf-lua".live_grep_glob()<CR>', desc = 'Live Grep' },
      { '<C-\\>', '<Cmd>lua require"fzf-lua".buffers()<CR>', desc = 'Buffers' },
      { '<C-b>', '<Cmd>lua require"fzf-lua".builtin()<CR>', desc = 'Builtin commands' },
      { '<F1>', '<Cmd>lua require"fzf-lua".help_tags()<CR>', desc = 'Neovim help' },
      { '<leader>h', '<Cmd>lua require"fzf-lua".oldfiles()<CR>', desc = 'Find [H]istory' },
      { '<leader>fw', '<Cmd>lua require"fzf-lua".grep_cword()<CR>', desc = '[F]ind current [W]ord' },
      { '<leader>fd', '<Cmd>lua require"fzf-lua".diagnostics_workspace()<CR>', desc = '[F]ind [D]iagnostics' },
      { '<leader>fi', '<Cmd>lua require"fzf-lua".lsp_incoming_calls()<CR>', desc = '[F]ind [I]ncoming calls' },
    },
  },
  {
    enabled = false,
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
    enabled = false,
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable('make') == 1,
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
}
