local Plugin = { 'glepnir/lspsaga.nvim' }

Plugin.branch = 'main'

Plugin.opts = {
  implement = {
    virtual_text = false,
  },
}

function Plugin.init()
  local keymap = vim.keymap.set

  -- Lsp finder find the symbol definition implement reference
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  keymap('n', 'gh', '<cmd>Lspsaga finder<CR>', { silent = true })

  -- Code action
  keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
  keymap('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', { silent = true })

  -- Rename
  keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', { silent = true })

  -- Show line diagnostics
  keymap('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })

  -- Show cursor diagnostic
  keymap('n', '<leader>d', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })

  -- Diagnsotic jump can use `<c-o>` to jump back
  keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
  keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })

  -- Hover Doc
  keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
end

return Plugin
