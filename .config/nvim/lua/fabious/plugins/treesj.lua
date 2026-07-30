return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  -- Defaults are <leader>m/j/s, which collide with Grapple's <leader>m
  -- and shadow <leader>s/ in fzf-lua.
  opts = { use_default_keymaps = false },
  keys = {
    { '<leader>J', '<cmd>TSJToggle<cr>', desc = 'Toggle split/join node' },
  },
}
