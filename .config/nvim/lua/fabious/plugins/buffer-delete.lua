return {
  'ojroques/nvim-bufdel',
  event = 'VeryLazy',
  keys = {
    { '<leader>bd', '<cmd>BufDel<cr>', desc = 'Delete the current buffer' },
    { '<leader>bD', '<cmd>BufDel!<cr>', desc = 'Force delete the current buffer' },
    { '<leader>ba', '<cmd>BufDelOthers<cr>', desc = 'Delete all except current buffer' },
  },
}
