return {
  -- Copilot
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      vim.g.copilot_no_tab_map = true

      -- Accept with Ctrl+l (moves cursor into the phantom text)
      vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false,
      })

      -- Cycle with Ctrl+j and Ctrl+k
      vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)')
    end,
  },
}
