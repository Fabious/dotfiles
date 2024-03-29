return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Neotree' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = true,
    })
  end,
}
