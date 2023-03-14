local keymap = vim.keymap.set

require('lspsaga').setup {}

-- Lsp finder find the symbol definition implement reference
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })

-- Code action
keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
keymap('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', { silent = true })

-- Rename
keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', { silent = true })

-- Show line diagnostics
keymap('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })

-- Show cursor diagnostic
keymap('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })

-- Only jump to error
keymap('n', '[E', function()
  require('lspsaga.diagnostic').goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { silent = true })
keymap('n', ']E', function()
  require('lspsaga.diagnostic').goto_next { severity = vim.diagnostic.severity.ERROR }
end, { silent = true })

-- Hover Doc
keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
