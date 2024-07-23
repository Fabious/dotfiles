return {
  'cbochs/grapple.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  opts = {
    scope = 'git_branch',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>M', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    { '<leader>n', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
    { '<leader>p', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },

    { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
    { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
    { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
    { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },
    { '<leader>5', '<cmd>Grapple select index=5<cr>', desc = 'Select fifth tag' },

    { '<leader>g1', '<cmd>Grapple tag index=1<cr>', desc = 'Bind first tag' },
    { '<leader>g2', '<cmd>Grapple tag index=2<cr>', desc = 'Bind second tag' },
    { '<leader>g3', '<cmd>Grapple tag index=3<cr>', desc = 'Bind third tag' },
    { '<leader>g4', '<cmd>Grapple tag index=4<cr>', desc = 'Bind fourth tag' },
    { '<leader>g5', '<cmd>Grapple tag index=5<cr>', desc = 'Bind fifth tag' },
  },
}
