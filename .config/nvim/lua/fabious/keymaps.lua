local map = function(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, opts or { noremap = true, silent = true })
end

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- map({ 'n', 'v' }, '<Space>', '<Nop>')

-- Remap for dealing with word wrap
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- [[ My Keymaps ]]
-- best keymaps
map('i', 'jk', '<ESC>')
map('n', ';', ':', { noremap = false })
map('n', 'Q', '<Nop>')
map('n', 'q:', '<Nop>')
map('n', '<C-c>', '<Esc>')
map('n', '<leader>1', ':e ~/.config/nvim/lua/fabious/init.lua<CR>', { desc = 'Open confing' })
map('n', '<leader>2', ':e ~/.config/nvim/lua/fabious/keymaps.lua<CR>', { desc = 'Open keymaps' })
map('n', '<leader>4', ':e ~/.config/nvim/lua/fabious/packer.lua<CR>', { desc = 'Open plugins' })
map('n', '<leader>5', ':PackerSync<CR>', { desc = 'reload Packer' })

map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>o', ':only<CR>')

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<S-l>', ':bnext<CR>')
map('n', '<S-h>', ':bprevious<CR>')

map('x', '<leader>p', '"_dP')
map('n', '<leader>d', '"_d')
map('v', '<leader>d', '"_d')
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
map('n', '<leader>Y', '"+Y')

-- tabs
map('n', '<leader>ta', ':$tabnew<CR>')
map('n', '<leader>tc', ':tabclose<CR>')
map('n', '<leader>to', ':tabonly<CR>')
map('n', '<leader>tn', ':tabn<CR>')
map('n', '<leader>tp', ':tabp<CR>')
-- move current tab to previous position
map('n', '<leader>tmp', ':-tabmove<CR>')
-- move current tab to next position
map('n', '<leader>tmn', ':+tabmove<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>vf', vim.diagnostic.open_float)
map('n', '<leader>vl', vim.diagnostic.setloclist)

map('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')
